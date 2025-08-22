# Tutorial 6: Deploying Your First Agent

**Duration**: 3-4 hours  
**Prerequisites**: [Tutorial 5: Prompt Engineering for Agents](../05-prompt-engineering/)  
**Goal**: Learn how to deploy your agent for real-world use

## 🎯 Learning Objectives

After completing this tutorial, you will:
- Package your agent application properly
- Configure environment and secrets management
- Create web interfaces with Streamlit
- Implement basic monitoring and logging
- Containerize with Docker
- Deploy to cloud platforms

---

## 📦 Application Packaging

### Project Structure
```
my-agent-app/
├── app/
│   ├── __init__.py
│   ├── agent.py
│   ├── tools.py
│   └── config.py
├── tests/
│   ├── test_agent.py
│   └── test_tools.py
├── deployment/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── requirements.txt
├── .env.example
├── README.md
└── setup.py
```

### Configuration Management
```python
# app/config.py
import os
from dataclasses import dataclass

@dataclass
class Config:
    openai_api_key: str
    environment: str = "development"
    log_level: str = "INFO"
    max_tokens: int = 1000
    temperature: float = 0.7
    
    @classmethod
    def from_env(cls):
        return cls(
            openai_api_key=os.getenv("OPENAI_API_KEY"),
            environment=os.getenv("ENVIRONMENT", "development"),
            log_level=os.getenv("LOG_LEVEL", "INFO"),
            max_tokens=int(os.getenv("MAX_TOKENS", "1000")),
            temperature=float(os.getenv("TEMPERATURE", "0.7"))
        )
```

---

## 🌐 Web Interface with Streamlit

### Basic Streamlit App
```python
# streamlit_app.py
import streamlit as st
from app.agent import create_agent
from app.config import Config

def main():
    st.title("🤖 My AI Agent")
    st.sidebar.header("Configuration")
    
    # Initialize agent
    if "agent" not in st.session_state:
        config = Config.from_env()
        st.session_state.agent = create_agent(config)
        st.session_state.messages = []
    
    # Chat interface
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])
    
    # User input
    if prompt := st.chat_input("Ask me anything..."):
        # Add user message
        st.session_state.messages.append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)
        
        # Get agent response
        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                response = st.session_state.agent.run(prompt)
                st.markdown(response)
                st.session_state.messages.append({"role": "assistant", "content": response})

if __name__ == "__main__":
    main()
```

### Advanced Streamlit Features
```python
# Advanced interface with controls
def advanced_interface():
    st.sidebar.header("Agent Settings")
    
    # Model selection
    model = st.sidebar.selectbox(
        "Choose Model",
        ["gpt-3.5-turbo", "gpt-4", "gpt-4-turbo"]
    )
    
    # Temperature control
    temperature = st.sidebar.slider(
        "Temperature",
        min_value=0.0,
        max_value=1.0,
        value=0.7,
        step=0.1
    )
    
    # Tool selection
    available_tools = ["web_search", "calculator", "weather", "wikipedia"]
    selected_tools = st.sidebar.multiselect(
        "Available Tools",
        available_tools,
        default=available_tools
    )
    
    # Memory settings
    memory_type = st.sidebar.radio(
        "Memory Type",
        ["buffer", "summary", "vector"]
    )
    
    return {
        "model": model,
        "temperature": temperature,
        "tools": selected_tools,
        "memory_type": memory_type
    }
```

---

## 📊 Monitoring and Logging

### Logging Setup
```python
# app/logging_config.py
import logging
import sys
from datetime import datetime

def setup_logging(log_level="INFO"):
    """Configure logging for the application"""
    
    # Create logger
    logger = logging.getLogger("agent_app")
    logger.setLevel(getattr(logging, log_level))
    
    # Create console handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.INFO)
    
    # Create file handler
    file_handler = logging.FileHandler(
        f"logs/agent_{datetime.now().strftime('%Y%m%d')}.log"
    )
    file_handler.setLevel(logging.DEBUG)
    
    # Create formatter
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    console_handler.setFormatter(formatter)
    file_handler.setFormatter(formatter)
    
    # Add handlers to logger
    logger.addHandler(console_handler)
    logger.addHandler(file_handler)
    
    return logger
```

### Metrics Collection
```python
# app/metrics.py
import time
from dataclasses import dataclass, field
from typing import Dict, List

@dataclass
class AgentMetrics:
    total_requests: int = 0
    successful_requests: int = 0
    failed_requests: int = 0
    total_response_time: float = 0.0
    tool_usage: Dict[str, int] = field(default_factory=dict)
    error_types: Dict[str, int] = field(default_factory=dict)
    
    def record_request(self, success: bool, response_time: float, 
                      tools_used: List[str] = None, error_type: str = None):
        self.total_requests += 1
        self.total_response_time += response_time
        
        if success:
            self.successful_requests += 1
        else:
            self.failed_requests += 1
            if error_type:
                self.error_types[error_type] = self.error_types.get(error_type, 0) + 1
        
        if tools_used:
            for tool in tools_used:
                self.tool_usage[tool] = self.tool_usage.get(tool, 0) + 1
    
    def get_success_rate(self) -> float:
        if self.total_requests == 0:
            return 0.0
        return self.successful_requests / self.total_requests
    
    def get_average_response_time(self) -> float:
        if self.total_requests == 0:
            return 0.0
        return self.total_response_time / self.total_requests
```

---

## 🐳 Docker Deployment

### Dockerfile
```dockerfile
# Dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ ./app/
COPY streamlit_app.py .

# Create logs directory
RUN mkdir -p logs

# Expose port
EXPOSE 8501

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8501/_stcore/health

# Run the application
CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
```

### Docker Compose
```yaml
# docker-compose.yml
version: '3.8'

services:
  agent-app:
    build: .
    ports:
      - "8501:8501"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - ENVIRONMENT=production
      - LOG_LEVEL=INFO
    volumes:
      - ./logs:/app/logs
    restart: unless-stopped
    
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: unless-stopped

volumes:
  redis_data:
```

---

## ☁️ Cloud Deployment Options

### Streamlit Cloud
```bash
# 1. Push code to GitHub
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main

# 2. Deploy to Streamlit Cloud
# Visit share.streamlit.io and connect your GitHub repo
```

### Heroku Deployment
```bash
# 1. Install Heroku CLI
# 2. Create Heroku app
heroku create your-agent-app

# 3. Set environment variables
heroku config:set OPENAI_API_KEY=your_key_here

# 4. Deploy
git push heroku main
```

### AWS EC2 Deployment
```bash
# 1. Launch EC2 instance
# 2. Install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start

# 3. Clone and run
git clone https://github.com/yourusername/your-repo.git
cd your-repo
sudo docker-compose up -d
```

---

## 🔒 Security Best Practices

### Environment Variables
```bash
# .env file (never commit to git)
OPENAI_API_KEY=sk-...
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=localhost,yourapp.com
```

### Input Validation
```python
def validate_input(user_input: str) -> bool:
    """Validate user input for security"""
    
    # Check length
    if len(user_input) > 1000:
        return False
    
    # Check for malicious patterns
    dangerous_patterns = [
        "eval(", "exec(", "__import__",
        "system(", "shell=True"
    ]
    
    for pattern in dangerous_patterns:
        if pattern in user_input.lower():
            return False
    
    return True
```

### Rate Limiting
```python
from functools import wraps
import time

def rate_limit(max_calls=10, window=60):
    """Rate limiting decorator"""
    calls = {}
    
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            now = time.time()
            key = f"{func.__name__}_{id(args)}"
            
            if key not in calls:
                calls[key] = []
            
            # Remove old calls
            calls[key] = [call_time for call_time in calls[key] 
                         if now - call_time < window]
            
            # Check rate limit
            if len(calls[key]) >= max_calls:
                raise Exception("Rate limit exceeded")
            
            calls[key].append(now)
            return func(*args, **kwargs)
        
        return wrapper
    return decorator
```

---

## 🧪 Testing Deployment

### Integration Tests
```python
# tests/test_deployment.py
import requests
import pytest

def test_health_endpoint():
    """Test application health"""
    response = requests.get("http://localhost:8501/_stcore/health")
    assert response.status_code == 200

def test_agent_response():
    """Test agent functionality"""
    # This would test your specific API endpoints
    pass

def test_docker_deployment():
    """Test Docker container"""
    import subprocess
    
    # Build and run container
    subprocess.run(["docker", "build", "-t", "test-agent", "."])
    subprocess.run(["docker", "run", "-d", "-p", "8501:8501", "test-agent"])
    
    # Test application
    time.sleep(10)  # Wait for startup
    response = requests.get("http://localhost:8501")
    assert response.status_code == 200
```

---

## 📈 Performance Optimization

### Caching Strategies
```python
from functools import lru_cache
import redis

# In-memory caching
@lru_cache(maxsize=100)
def cached_tool_call(tool_name, input_hash):
    """Cache tool results"""
    return tool_registry[tool_name](input_hash)

# Redis caching
redis_client = redis.Redis(host='localhost', port=6379, db=0)

def cache_response(key, response, ttl=3600):
    """Cache response in Redis"""
    redis_client.setex(key, ttl, response)

def get_cached_response(key):
    """Get cached response from Redis"""
    return redis_client.get(key)
```

---

## 🎯 Production Checklist

### Before Deployment
- [ ] Environment variables configured
- [ ] Secrets properly managed
- [ ] Logging implemented
- [ ] Error handling robust
- [ ] Rate limiting in place
- [ ] Input validation working
- [ ] Tests passing
- [ ] Health checks configured
- [ ] Monitoring set up
- [ ] Backup strategy defined

### After Deployment
- [ ] Application accessible
- [ ] Logs flowing correctly
- [ ] Metrics being collected
- [ ] Alerts configured
- [ ] Performance acceptable
- [ ] Security hardened
- [ ] Documentation updated
- [ ] Team trained on operations

---

## 🎯 Exercises

1. **Multi-Environment Setup**: Configure staging and production environments
2. **Advanced Monitoring**: Add custom metrics and alerting
3. **Auto-scaling**: Implement horizontal scaling with load balancers
4. **CI/CD Pipeline**: Set up automated testing and deployment
5. **Performance Testing**: Load test your deployed agent

---

## 🏆 Completion Certificate

Congratulations! You've completed all 6 beginner tutorials. You now have:
- Built functional AI agents
- Integrated external tools and APIs
- Implemented memory and state management
- Mastered prompt engineering techniques
- Deployed production-ready applications

**Ready for the next level?** Check out our [Intermediate Tutorial Series](../../intermediate/) or explore [Advanced Multi-Agent Systems](../../advanced/).

---

## 📖 Additional Resources

- [Production Deployment Best Practices](../../../resources/cheat-sheets/deployment-guide.md)
- [Monitoring and Observability Guide](../../../tools/README.md#monitoring-tools)
- [Security Checklist](../../../resources/cheat-sheets/security-guide.md)

---

*This completes the [Beginner Tutorial Series](../) for Agentic AI development. Great work!*