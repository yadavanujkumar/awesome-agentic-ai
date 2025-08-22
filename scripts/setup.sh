#!/bin/bash

# Agentic AI Development Environment Setup Script
# This script sets up a complete development environment for AI agents

set -e  # Exit on any error

echo "🤖 Setting up Agentic AI Development Environment..."
echo "================================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed. Please install Python 3.8 or higher."
    exit 1
fi

# Check Python version
python_version=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
required_version="3.8"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "❌ Python 3.8 or higher is required. Current version: $python_version"
    exit 1
fi

echo "✅ Python $python_version detected"

# Create project directory
read -p "Enter project name (default: my-agentic-ai-project): " project_name
project_name=${project_name:-my-agentic-ai-project}

if [ -d "$project_name" ]; then
    echo "❌ Directory $project_name already exists!"
    exit 1
fi

mkdir "$project_name"
cd "$project_name"

echo "📁 Created project directory: $project_name"

# Create virtual environment
echo "🔧 Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Upgrade pip
echo "⬆️ Upgrading pip..."
pip install --upgrade pip

# Install core packages
echo "📦 Installing core AI agent packages..."
pip install langchain
pip install langchain-community
pip install langchain-openai
pip install autogen-agentchat
pip install crewai
pip install llamaindex
pip install openai
pip install anthropic

# Install development tools
echo "🛠️ Installing development tools..."
pip install streamlit
pip install gradio
pip install chainlit
pip install jupyter
pip install langsmith
pip install python-dotenv

# Install optional monitoring tools
echo "📊 Installing monitoring and debugging tools..."
pip install wandb
pip install rich
pip install loguru

# Create basic project structure
echo "🏗️ Creating project structure..."
mkdir -p src/{agents,tools,utils}
mkdir -p examples
mkdir -p tests
mkdir -p docs
mkdir -p data
mkdir -p logs

# Create environment file template
echo "📝 Creating environment file template..."
cat > .env.example << 'EOF'
# API Keys - Replace with your actual keys
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here
LANGCHAIN_API_KEY=your_langchain_api_key_here

# Optional: Weights & Biases for experiment tracking
WANDB_API_KEY=your_wandb_api_key_here

# Optional: LangSmith for monitoring
LANGCHAIN_TRACING_V2=true
LANGCHAIN_ENDPOINT=https://api.smith.langchain.com
LANGCHAIN_PROJECT=your_project_name

# Agent Configuration
DEFAULT_MODEL=gpt-3.5-turbo
TEMPERATURE=0.7
MAX_TOKENS=1000
EOF

# Create gitignore
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Environment variables
.env
.env.local

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual environment
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log

# Data files
data/
*.csv
*.json
*.pkl

# Jupyter Notebook
.ipynb_checkpoints

# Weights & Biases
wandb/
EOF

# Create requirements.txt
echo "📝 Creating requirements.txt..."
pip freeze > requirements.txt

# Create basic example files
echo "📝 Creating example files..."

# Simple LangChain example
cat > examples/simple_langchain_agent.py << 'EOF'
"""
Simple LangChain Agent Example
A basic agent that can answer questions and perform calculations.
"""

import os
from dotenv import load_dotenv
from langchain.agents import initialize_agent, Tool
from langchain.llms import OpenAI

# Load environment variables
load_dotenv()

def calculator(expression: str) -> str:
    """Simple calculator function"""
    try:
        result = eval(expression)
        return f"The result is: {result}"
    except Exception as e:
        return f"Error in calculation: {str(e)}"

def main():
    # Check if API key is set
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    # Create tools
    tools = [
        Tool(
            name="Calculator",
            func=calculator,
            description="Useful for mathematical calculations. Input should be a mathematical expression."
        )
    ]
    
    # Initialize LLM
    llm = OpenAI(temperature=0)
    
    # Create agent
    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent="zero-shot-react-description",
        verbose=True
    )
    
    # Example queries
    queries = [
        "What is 25 * 4 + 10?",
        "Calculate the square root of 144",
        "What is 20% of 150?"
    ]
    
    for query in queries:
        print(f"\n🤖 Agent Query: {query}")
        try:
            result = agent.run(query)
            print(f"📝 Agent Response: {result}")
        except Exception as e:
            print(f"❌ Error: {str(e)}")

if __name__ == "__main__":
    main()
EOF

# AutoGen example
cat > examples/simple_autogen_chat.py << 'EOF'
"""
Simple AutoGen Multi-Agent Example
Two agents having a conversation to solve a problem.
"""

import os
from dotenv import load_dotenv
import autogen

# Load environment variables
load_dotenv()

def main():
    # Check if API key is set
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    # Configuration for the LLM
    config_list = [
        {
            "model": "gpt-3.5-turbo",
            "api_key": os.getenv("OPENAI_API_KEY")
        }
    ]
    
    # Create assistant agent
    assistant = autogen.AssistantAgent(
        name="Assistant",
        system_message="You are a helpful AI assistant skilled in problem-solving and analysis.",
        llm_config={"config_list": config_list}
    )
    
    # Create user proxy agent
    user_proxy = autogen.UserProxyAgent(
        name="User",
        human_input_mode="NEVER",
        max_consecutive_auto_reply=3,
        code_execution_config=False
    )
    
    # Start conversation
    print("🤖 Starting AutoGen conversation...")
    user_proxy.initiate_chat(
        assistant,
        message="Help me create a plan for learning AI agents. I want to understand the key concepts and practical implementation steps."
    )

if __name__ == "__main__":
    main()
EOF

# CrewAI example
cat > examples/simple_crewai_team.py << 'EOF'
"""
Simple CrewAI Team Example
A research team with different roles working together.
"""

import os
from dotenv import load_dotenv
from crewai import Agent, Task, Crew

# Load environment variables
load_dotenv()

def main():
    # Check if API key is set
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    # Create researcher agent
    researcher = Agent(
        role='Research Analyst',
        goal='Gather comprehensive information on AI agent frameworks',
        backstory="""You are an expert research analyst with deep knowledge of AI technologies.
        You excel at finding relevant information and identifying key trends.""",
        verbose=True
    )
    
    # Create writer agent
    writer = Agent(
        role='Content Writer',
        goal='Create engaging and informative content based on research',
        backstory="""You are a skilled technical writer who can transform complex research
        into clear, actionable content for developers and practitioners.""",
        verbose=True
    )
    
    # Create research task
    research_task = Task(
        description="""Research the top 3 AI agent frameworks (LangChain, AutoGen, CrewAI).
        For each framework, identify:
        1. Key features and capabilities
        2. Best use cases
        3. Getting started steps
        4. Pros and cons""",
        agent=researcher
    )
    
    # Create writing task
    writing_task = Task(
        description="""Based on the research findings, write a comprehensive comparison guide
        that helps developers choose the right AI agent framework for their project.
        Include practical examples and recommendations.""",
        agent=writer
    )
    
    # Create crew
    crew = Crew(
        agents=[researcher, writer],
        tasks=[research_task, writing_task],
        verbose=2
    )
    
    # Execute the crew
    print("🤖 Starting CrewAI team execution...")
    result = crew.kickoff()
    
    print("\n" + "="*50)
    print("📝 Final Result:")
    print("="*50)
    print(result)

if __name__ == "__main__":
    main()
EOF

# Streamlit demo app
cat > examples/streamlit_agent_demo.py << 'EOF'
"""
Streamlit Agent Demo
Interactive web interface for AI agents.
"""

import os
import streamlit as st
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

st.set_page_config(
    page_title="AI Agent Demo",
    page_icon="🤖",
    layout="wide"
)

st.title("🤖 AI Agent Demo")
st.write("Interactive demonstration of AI agents")

# Sidebar for configuration
st.sidebar.header("Configuration")
api_key = st.sidebar.text_input("OpenAI API Key", type="password", value=os.getenv("OPENAI_API_KEY", ""))
model = st.sidebar.selectbox("Model", ["gpt-3.5-turbo", "gpt-4"])
temperature = st.sidebar.slider("Temperature", 0.0, 1.0, 0.7)

# Main interface
if api_key:
    st.success("✅ API Key configured")
    
    # Chat interface
    if "messages" not in st.session_state:
        st.session_state.messages = []
    
    # Display chat messages
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])
    
    # Chat input
    if prompt := st.chat_input("Ask your AI agent..."):
        # Add user message
        st.session_state.messages.append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)
        
        # Add assistant response (placeholder)
        with st.chat_message("assistant"):
            response = f"This is a demo response to: {prompt}"
            st.markdown(response)
            st.session_state.messages.append({"role": "assistant", "content": response})
else:
    st.warning("⚠️ Please configure your OpenAI API key in the sidebar")
    
st.sidebar.markdown("---")
st.sidebar.markdown("### 🚀 Quick Start")
st.sidebar.markdown("1. Enter your OpenAI API key")
st.sidebar.markdown("2. Choose your model settings")
st.sidebar.markdown("3. Start chatting with the agent")

# Footer
st.markdown("---")
st.markdown("Built with ❤️ using Streamlit and AI agents")
EOF

# Create README for the project
cat > README.md << 'EOF'
# My Agentic AI Project

Welcome to your AI agent development environment! This project is set up with all the essential tools and frameworks for building intelligent agents.

## 🚀 Quick Start

1. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```

2. **Set up your API keys:**
   ```bash
   cp .env.example .env
   # Edit .env file with your actual API keys
   ```

3. **Run example agents:**
   ```bash
   # Simple LangChain agent
   python examples/simple_langchain_agent.py
   
   # AutoGen multi-agent conversation
   python examples/simple_autogen_chat.py
   
   # CrewAI team collaboration
   python examples/simple_crewai_team.py
   
   # Streamlit web interface
   streamlit run examples/streamlit_agent_demo.py
   ```

## 📁 Project Structure

```
my-agentic-ai-project/
├── src/                    # Main source code
│   ├── agents/            # Agent implementations
│   ├── tools/             # Custom tools and utilities
│   └── utils/             # Helper functions
├── examples/              # Example implementations
├── tests/                 # Unit tests
├── docs/                  # Documentation
├── data/                  # Data files
├── logs/                  # Log files
├── .env.example           # Environment variables template
├── requirements.txt       # Python dependencies
└── README.md             # This file
```

## 🛠️ Installed Frameworks

- **LangChain**: For general LLM applications and tool integration
- **AutoGen**: For multi-agent conversations and collaboration
- **CrewAI**: For role-based agent teams
- **LlamaIndex**: For data indexing and knowledge bases
- **Streamlit**: For building web interfaces
- **Gradio**: For creating demos
- **Jupyter**: For interactive development

## 📚 Next Steps

1. Explore the [Awesome Agentic AI repository](https://github.com/yadavanujkumar/awesome-agentic-ai) for comprehensive guides
2. Check out the [cheat sheets](https://github.com/yadavanujkumar/awesome-agentic-ai/tree/main/resources/cheat-sheets) for best practices
3. Join the community discussions and contribute your own examples

## 🤝 Contributing

Feel free to add your own agents, tools, and examples to this project. Share your innovations with the community!

## 📞 Support

- GitHub Issues: [Report bugs or request features](https://github.com/yadavanujkumar/awesome-agentic-ai/issues)
- Discussions: [Join community discussions](https://github.com/yadavanujkumar/awesome-agentic-ai/discussions)

Happy building! 🤖✨
EOF

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Your AI agent development environment is ready!"
echo ""
echo "📁 Project created in: $(pwd)"
echo ""
echo "🔧 Next steps:"
echo "1. cd $project_name"
echo "2. source venv/bin/activate"
echo "3. cp .env.example .env"
echo "4. Edit .env with your API keys"
echo "5. python examples/simple_langchain_agent.py"
echo ""
echo "📚 Documentation: https://github.com/yadavanujkumar/awesome-agentic-ai"
echo "🎥 Video tutorials: https://github.com/yadavanujkumar/awesome-agentic-ai/tree/main/resources#-video-resources"
echo "📋 Cheat sheets: https://github.com/yadavanujkumar/awesome-agentic-ai/tree/main/resources/cheat-sheets"
echo ""
echo "Happy coding! 🤖✨"