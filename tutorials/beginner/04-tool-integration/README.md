# Tutorial 4: Tool Integration and Function Calling

**Duration**: 3-4 hours  
**Prerequisites**: [Tutorial 3: Agent Memory and State Management](../03-memory-and-state/)  
**Goal**: Expand your agent's capabilities by integrating external tools and APIs

## 🎯 Learning Objectives

After completing this tutorial, you will:
- Create custom tools for your agent
- Master API integration patterns
- Implement file system operations
- Connect to databases
- Build tool selection and routing logic
- Handle errors for external services

---

## 🧰 Types of Tools

### Built-in Tools
- **Web Search**: DuckDuckGo, Google Search, Bing
- **Wikipedia**: Knowledge retrieval
- **Calculator**: Mathematical operations
- **File System**: Read/write files
- **Shell**: Execute system commands

### Custom Tools
- **API Integrations**: REST, GraphQL, webhooks
- **Database Operations**: SQL queries, document stores
- **Data Processing**: CSV, JSON, XML parsing
- **External Services**: Email, SMS, cloud services

---

## 🛠️ Building Custom Tools

### Simple Function Tool

```python
from langchain.tools import Tool

def weather_checker(location):
    """Get weather information for a location"""
    # Placeholder implementation
    return f"Weather in {location}: Sunny, 75°F"

weather_tool = Tool(
    name="Weather Checker",
    func=weather_checker,
    description="Get current weather for any location"
)
```

### API Integration Tool

```python
import requests
from langchain.tools import Tool

def news_search(query):
    """Search for recent news articles"""
    try:
        # Example API call (replace with real API)
        response = requests.get(f"https://api.news.com/search?q={query}")
        data = response.json()
        return f"Found {len(data['articles'])} articles about {query}"
    except Exception as e:
        return f"Error searching news: {str(e)}"

news_tool = Tool(
    name="News Search",
    func=news_search,
    description="Search for recent news articles on any topic"
)
```

---

## 📊 Database Integration

### SQL Database Tool

```python
import sqlite3
from langchain.tools import Tool

def query_database(query):
    """Execute SQL queries on local database"""
    try:
        conn = sqlite3.connect('agent_data.db')
        cursor = conn.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        conn.close()
        return f"Query results: {results}"
    except Exception as e:
        return f"Database error: {str(e)}"

db_tool = Tool(
    name="Database Query",
    func=query_database,
    description="Execute SQL queries on the local database"
)
```

---

## 🔧 Advanced Tool Patterns

### Tool Chaining
```python
def multi_step_research(topic):
    """Perform research using multiple tools"""
    # Step 1: Search web
    web_results = web_search_tool.run(topic)
    
    # Step 2: Get Wikipedia summary
    wiki_results = wikipedia_tool.run(topic)
    
    # Step 3: Combine and summarize
    combined = f"Web: {web_results}\nWiki: {wiki_results}"
    return summarize_tool.run(combined)
```

### Error Handling and Retry Logic
```python
import time
from functools import wraps

def retry_on_failure(max_retries=3, delay=1):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_retries):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_retries - 1:
                        return f"Tool failed after {max_retries} attempts: {str(e)}"
                    time.sleep(delay)
            return wrapper
        return decorator
```

---

## 📚 Practical Examples

Complete implementation examples available in:
- `examples/api_tools.py` - REST API integrations
- `examples/file_tools.py` - File system operations
- `examples/database_tools.py` - Database connectivity
- `examples/custom_tools.py` - Building specialized tools

---

## 🧪 Testing Tools

### Unit Testing Tool Functions
```python
def test_weather_tool():
    result = weather_checker("New York")
    assert "New York" in result
    assert "°F" in result or "°C" in result

def test_api_error_handling():
    # Test with invalid input
    result = news_search("")
    assert "Error" in result or "No results" in result
```

---

## 🎯 Exercises

1. **Build Email Tool**: Create a tool that can send emails via SMTP
2. **File Processing Tool**: Build a tool that can read and analyze CSV files
3. **Social Media Integration**: Connect to Twitter or LinkedIn APIs
4. **Data Visualization Tool**: Create charts and graphs from data
5. **Multi-tool Workflow**: Chain multiple tools for complex tasks

---

## 🚀 Next Steps

Continue to [Tutorial 5: Prompt Engineering for Agents](../05-prompt-engineering/)

---

*This tutorial is part of the [Beginner Tutorial Series](../) for Agentic AI development.*