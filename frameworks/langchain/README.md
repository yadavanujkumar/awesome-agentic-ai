# LangChain Framework Guide

LangChain is the most popular framework for building applications with Large Language Models (LLMs). It provides a comprehensive toolkit for developing AI agents with memory, tool usage, and reasoning capabilities.

## 🚀 Quick Start

### Installation
```bash
pip install langchain langchain-community langchain-openai
```

### Basic Agent Example
```python
from langchain.agents import initialize_agent, Tool
from langchain_openai import OpenAI
from langchain.memory import ConversationBufferMemory

# Define tools for your agent
def calculator(expression):
    """Evaluate mathematical expressions"""
    try:
        return str(eval(expression))
    except:
        return "Error in calculation"

tools = [
    Tool(
        name="Calculator",
        func=calculator,
        description="Useful for mathematical calculations. Input should be a valid mathematical expression."
    )
]

# Initialize LLM and memory
llm = OpenAI(temperature=0)
memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

# Create agent
agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent="conversational-react-description",
    memory=memory,
    verbose=True
)

# Use the agent
response = agent.run("What is 25 * 4 + 10? Also, remember that I like math problems.")
print(response)
```

## 🏗️ Agent Architectures

### 1. ReAct Agent (Reasoning + Acting)
Best for: General-purpose tasks with tool usage
```python
from langchain.agents import AgentType, initialize_agent

agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)
```

### 2. Conversational Agent
Best for: Chat-based applications with memory
```python
from langchain.memory import ConversationBufferWindowMemory

memory = ConversationBufferWindowMemory(
    k=5,  # Remember last 5 exchanges
    memory_key="chat_history",
    return_messages=True
)

agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent=AgentType.CONVERSATIONAL_REACT_DESCRIPTION,
    memory=memory
)
```

## 🛠️ Essential Tools

### Web Search Tool
```python
from langchain.tools import DuckDuckGoSearchRun

search = DuckDuckGoSearchRun()
tools.append(
    Tool(
        name="Web Search",
        func=search.run,
        description="Search the internet for current information"
    )
)
```

## 💾 Memory Systems

### ConversationBufferMemory
```python
from langchain.memory import ConversationBufferMemory

memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True
)
```

## 📚 Learn More

- [Official Documentation](https://python.langchain.com/)
- [Examples Directory](./examples/)
- [Best Practices Guide](./docs/best-practices.md)

## 🤝 Contributing

Found an issue or want to add examples? Please see our [Contributing Guide](../../CONTRIBUTING.md).