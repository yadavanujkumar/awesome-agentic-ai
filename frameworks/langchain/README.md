# LangChain & LangGraph Framework Guide

LangChain is a versatile framework for building applications with Large Language Models (LLMs). Combined with **LangGraph**, it provides a production-grade runtime for stateful, multi-actor agent systems with built-in persistence, tool calling, and human-in-the-loop control.

## 🚀 Quick Start

### Installation
```bash
pip install langchain langchain-community langchain-openai langgraph
```

### Modern Tool-Calling Agent Example
```python
import ast
import operator
import os
from dotenv import load_dotenv
from langchain_core.tools import tool
from langchain_openai import ChatOpenAI
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate

load_dotenv()

# Safe arithmetic evaluation (No dangerous eval())
SAFE_OPS = {
    ast.Add: operator.add, ast.Sub: operator.sub,
    ast.Mult: operator.mul, ast.Div: operator.truediv,
    ast.Pow: operator.pow, ast.USub: operator.neg,
}

def safe_math_eval(node):
    if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
        return node.value
    elif isinstance(node, ast.BinOp) and type(node.op) in SAFE_OPS:
        return SAFE_OPS[type(node.op)](safe_math_eval(node.left), safe_math_eval(node.right))
    elif isinstance(node, ast.UnaryOp) and type(node.op) in SAFE_OPS:
        return SAFE_OPS[type(node.op)](safe_math_eval(node.operand))
    raise ValueError(f"Unsupported operation: {type(node).__name__}")

@tool
def calculator(expression: str) -> str:
    """Useful for mathematical calculations. Input must be an arithmetic expression like '25 * 4 + 10'."""
    try:
        parsed = ast.parse(expression.strip(), mode='eval')
        return f"Result: {safe_math_eval(parsed.body)}"
    except Exception as e:
        return f"Calculation error: {str(e)}"

# Initialize LLM and Prompt
llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
tools = [calculator]

prompt = ChatPromptTemplate.from_messages([
    ("system", "You are a helpful agent with access to arithmetic tools."),
    ("placeholder", "{chat_history}"),
    ("human", "{input}"),
    ("placeholder", "{agent_scratchpad}"),
])

# Create tool-calling agent executor
agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

# Run agent
response = agent_executor.invoke({"input": "What is 25 * 4 + 10?"})
print(response["output"])
```

## 🏗️ Recommended Architectures

### 1. Tool-Calling Agents (Standard for 2026)
Modern LLMs support native function/tool calling. Instead of fragile text-based ReAct string parsing, tool-calling agents use structured model outputs directly.

### 2. LangGraph for Stateful Workflows
For production systems requiring checkpoints, cyclical execution, or human approval:
```python
from typing import Annotated, TypedDict
from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages

class AgentState(TypedDict):
    messages: Annotated[list, add_messages]

workflow = StateGraph(AgentState)
# Define nodes, edges, conditional routing, and compile
app = workflow.compile()
```

## 🛠️ Essential Tools & Integrations

- **Search**: `from langchain_community.tools import DuckDuckGoSearchRun`
- **Tracing & Observability**: LangSmith (`export LANGCHAIN_TRACING_V2=true`)
- **Memory**: Modern LangGraph checkpoints (`MemorySaver`, `PostgresSaver`) for durable multi-turn conversation memory.

## 📚 Learn More

- [Official LangChain Documentation](https://python.langchain.com/)
- [LangGraph Documentation](https://langchain-ai.github.io/langgraph/)
- [Contributing Guide](../../CONTRIBUTING.md)
