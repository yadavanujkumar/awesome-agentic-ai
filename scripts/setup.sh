#!/bin/bash

# Agentic AI Development Environment Setup Script
# This script sets up a complete development environment for AI agents

set -e  # Exit on any error

echo "🤖 Setting up Agentic AI Development Environment..."
echo "================================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed. Please install Python 3.10 or higher."
    exit 1
fi

# Check Python version (requires Python 3.10+)
if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" 2>/dev/null; then
    echo "❌ Python 3.10 or higher is required."
    exit 1
fi

python_version=$(python3 --version 2>&1 | cut -d' ' -f2)
echo "✅ Python $python_version detected"

# Create project directory
if [ -t 0 ]; then
    read -p "Enter project name (default: my-agentic-ai-project): " project_name
fi
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
pip install langchain langchain-community langchain-openai
pip install pyautogen
pip install crewai
pip install llama-index
pip install pydantic pydantic-ai
pip install openai anthropic

# Install development tools
echo "🛠️ Installing development tools..."
pip install streamlit gradio chainlit jupyter langsmith python-dotenv

# Install optional monitoring & safety tools
echo "📊 Installing monitoring and utility tools..."
pip install wandb rich loguru simpleeval

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
DEFAULT_MODEL=gpt-4o-mini
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
*.py[cod]
*$py.class
*.so
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
.venv/

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
*.sqlite

# Jupyter Notebook
.ipynb_checkpoints

# Weights & Biases / Monitoring
wandb/
.agentops/
EOF

# Create requirements.txt
echo "📝 Creating requirements.txt..."
pip freeze > requirements.txt

# Create basic example files
echo "📝 Creating example files..."

# Safe LangChain example
cat > examples/simple_langchain_agent.py << 'EOF'
"""
Simple LangChain Agent Example
A safe agent that can answer questions and perform arithmetic calculations.
"""

import ast
import operator
import os
from dotenv import load_dotenv
from langchain_core.tools import tool
from langchain_openai import ChatOpenAI

# Load environment variables
load_dotenv()

SAFE_OPERATORS = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.truediv,
    ast.Pow: operator.pow,
    ast.USub: operator.neg,
}

def safe_math_eval(node):
    """Safely evaluates an AST math expression without using dangerous eval()"""
    if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
        return node.value
    elif isinstance(node, ast.BinOp) and type(node.op) in SAFE_OPERATORS:
        left = safe_math_eval(node.left)
        right = safe_math_eval(node.right)
        return SAFE_OPERATORS[type(node.op)](left, right)
    elif isinstance(node, ast.UnaryOp) and type(node.op) in SAFE_OPERATORS:
        return SAFE_OPERATORS[type(node.op)](safe_math_eval(node.operand))
    raise ValueError(f"Unsupported math operation: {type(node).__name__}")

@tool
def calculator(expression: str) -> str:
    """Useful for mathematical calculations. Input must be a valid math expression like '25 * 4 + 10'."""
    try:
        parsed = ast.parse(expression.strip(), mode='eval')
        result = safe_math_eval(parsed.body)
        return f"The result is: {result}"
    except Exception as e:
        return f"Error in calculation: {str(e)}"

def main():
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    llm_with_tools = llm.bind_tools([calculator])
    
    queries = [
        "What is 25 * 4 + 10?",
        "Calculate 12 ** 2",
        "What is 150 * 0.2?"
    ]
    
    for query in queries:
        print(f"\n🤖 Query: {query}")
        try:
            ai_msg = llm_with_tools.invoke(query)
            if ai_msg.tool_calls:
                for tool_call in ai_msg.tool_calls:
                    if tool_call["name"] == "calculator":
                        tool_output = calculator.invoke(tool_call["args"])
                        print(f"🔧 Tool Output: {tool_output}")
            else:
                print(f"📝 Response: {ai_msg.content}")
        except Exception as e:
            print(f"❌ Error: {str(e)}")

if __name__ == "__main__":
    main()
EOF

# AutoGen example
cat > examples/simple_autogen_chat.py << 'EOF'
"""
Simple AutoGen Multi-Agent Example
Two agents having a conversation to solve a problem using pyautogen.
"""

import os
from dotenv import load_dotenv
import autogen

# Load environment variables
load_dotenv()

def main():
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    config_list = [
        {
            "model": "gpt-4o-mini",
            "api_key": os.getenv("OPENAI_API_KEY")
        }
    ]
    
    assistant = autogen.AssistantAgent(
        name="Assistant",
        system_message="You are a helpful AI assistant skilled in problem-solving and analysis.",
        llm_config={"config_list": config_list}
    )
    
    user_proxy = autogen.UserProxyAgent(
        name="User",
        human_input_mode="NEVER",
        max_consecutive_auto_reply=3,
        code_execution_config=False
    )
    
    print("🤖 Starting AutoGen conversation...")
    user_proxy.initiate_chat(
        assistant,
        message="Help me create a brief 3-step plan for learning AI agents."
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

load_dotenv()

def main():
    if not os.getenv("OPENAI_API_KEY"):
        print("❌ Please set your OPENAI_API_KEY in the .env file")
        return
    
    researcher = Agent(
        role='Research Analyst',
        goal='Gather concise information on modern AI agent frameworks',
        backstory="Expert research analyst specializing in AI agent frameworks.",
        verbose=True
    )
    
    writer = Agent(
        role='Content Writer',
        goal='Create engaging and actionable summary based on research',
        backstory="Technical writer who synthesizes research into practical guides.",
        verbose=True
    )
    
    research_task = Task(
        description="Identify key features of LangGraph, AutoGen, and CrewAI.",
        expected_output="A bulleted summary of key features for each framework.",
        agent=researcher
    )
    
    writing_task = Task(
        description="Write a 1-paragraph summary helping developers choose between them.",
        expected_output="A concise recommendation paragraph for developers.",
        agent=writer
    )
    
    crew = Crew(
        agents=[researcher, writer],
        tasks=[research_task, writing_task],
        verbose=True
    )
    
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

load_dotenv()

st.set_page_config(
    page_title="AI Agent Demo",
    page_icon="🤖",
    layout="wide"
)

st.title("🤖 AI Agent Demo")
st.write("Interactive demonstration of AI agents")

st.sidebar.header("Configuration")
api_key = st.sidebar.text_input("OpenAI API Key", type="password", value=os.getenv("OPENAI_API_KEY", ""))
model = st.sidebar.selectbox("Model", ["gpt-4o-mini", "gpt-4o"])
temperature = st.sidebar.slider("Temperature", 0.0, 1.0, 0.7)

if api_key:
    st.success("✅ API Key configured")
    
    if "messages" not in st.session_state:
        st.session_state.messages = []
    
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])
    
    if prompt := st.chat_input("Ask your AI agent..."):
        st.session_state.messages.append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)
        
        with st.chat_message("assistant"):
            response = f"Echo Agent Response (Model: {model}): {prompt}"
            st.markdown(response)
            st.session_state.messages.append({"role": "assistant", "content": response})
else:
    st.warning("⚠️ Please configure your OpenAI API key in the sidebar")

st.sidebar.markdown("---")
st.sidebar.markdown("### 🚀 Quick Start")
st.sidebar.markdown("1. Enter your OpenAI API key")
st.sidebar.markdown("2. Choose your model settings")
st.sidebar.markdown("3. Start chatting with the agent")

st.markdown("---")
st.markdown("Built with ❤️ using Streamlit and AI agents")
EOF

# Create README for the project
cat > README.md << 'EOF'
# My Agentic AI Project

Welcome to your AI agent development environment! This project is set up with modern tools and frameworks for building intelligent agents.

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
   # Safe LangChain agent with arithmetic tool
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

- **LangChain**: For LLM tool calling and workflows
- **AutoGen**: For multi-agent conversations and collaboration
- **CrewAI**: For role-based agent teams
- **PydanticAI**: For type-safe agent schemas
- **LlamaIndex**: For data indexing and knowledge retrieval
- **Streamlit**: For rapid web interfaces

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
echo ""
echo "Happy coding! 🤖✨"
