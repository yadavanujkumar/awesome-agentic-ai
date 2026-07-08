# 🤖 Agentic AI Resources

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub stars](https://img.shields.io/github/stars/yadavanujkumar/awesome-agentic-ai?style=social)](https://github.com/yadavanujkumar/awesome-agentic-ai/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/yadavanujkumar/awesome-agentic-ai?style=social)](https://github.com/yadavanujkumar/awesome-agentic-ai/network/members)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

> **Your complete hub for learning, building, and mastering Agentic AI systems** 🚀

Welcome to the most comprehensive resource for **Agentic AI** - the cutting-edge field where AI systems can act autonomously, make decisions, and collaborate with other agents to solve complex problems. Whether you're a beginner taking your first steps or an expert pushing the boundaries, this repository has everything you need.

## 🌟 What is Agentic AI?

**Agentic AI** refers to artificial intelligence systems that can:
- 🎯 **Act autonomously** towards specific goals
- 🧠 **Make decisions** based on their environment and objectives  
- 🤝 **Collaborate** with other agents and humans
- 🔧 **Use tools** and external resources dynamically
- 📚 **Learn and adapt** from experience and feedback
- 🎭 **Take on specialized roles** within larger systems

Unlike traditional AI that simply responds to inputs, agentic AI proactively pursues objectives, making it perfect for complex, real-world applications like research assistance, code generation, customer service, and automated business processes.

---

## 🗺️ Learning Roadmap

### 🌱 **Beginner Path** (4-6 weeks)
```
Week 1-2: Foundations
├── AI/ML basics and LLM fundamentals
├── Introduction to agents and autonomy concepts
└── Setting up development environment

Week 3-4: First Agent
├── Build a simple chatbot with LangChain
├── Add memory and conversation history
└── Integrate basic tool usage (web search, calculator)

Week 5-6: Enhancement
├── Improve agent reasoning with prompting techniques
├── Add error handling and safety measures
└── Deploy your first agent application
```

### ⚡ **Intermediate Path** (6-8 weeks)
```
Week 1-3: Multi-Agent Systems
├── Agent communication protocols
├── Role-based agent architectures
└── Collaborative problem-solving patterns

Week 4-5: Advanced Capabilities
├── Complex tool integration and function calling
├── Memory systems and knowledge management
└── Planning and reasoning frameworks

Week 6-8: Production Systems
├── Scalable agent architectures
├── Monitoring and debugging techniques
└── Performance optimization strategies
```

### 🚀 **Expert Path** (8-12 weeks)
```
Week 1-4: Cutting-Edge Research
├── Latest papers and techniques
├── Custom framework development
└── Novel agent architectures

Week 5-8: Enterprise Solutions
├── Large-scale multi-agent systems
├── Security and compliance considerations
└── Integration with enterprise systems

Week 9-12: Innovation
├── Contributing to open-source frameworks
├── Research and experimentation
└── Community leadership and knowledge sharing
```

---

## 🆕 July 2026 Update: Current Agentic AI Stack

> Refreshed on **July 8, 2026**. This list now prioritizes generally available, actively maintained, or clearly documented agent-building technologies over speculative version claims.

### 🔥 Model & API Direction
- **OpenAI Responses API + Agents SDK** - The Responses API is the primary building block for OpenAI tool-calling agents, while the Agents SDK adds a higher-level runtime for handoffs, tracing, guardrails, and multi-agent workflows.
- **OpenAI Assistants API migration** - Treat the Assistants API as legacy for new builds; prefer Responses API or Agents SDK unless you are maintaining an existing assistant.
- **Google Gemini + Agent Development Kit (ADK)** - ADK is Google's open-source, code-first framework for building, debugging, and deploying agents across Python, TypeScript, Go, Java, and Kotlin.
- **Microsoft Agent Framework** - The production successor to AutoGen and Semantic Kernel, combining multi-agent abstractions with enterprise features such as state, telemetry, type safety, filters, and multi-provider support.
- **Anthropic Claude tool use + MCP ecosystem** - Claude remains a strong option for tool-use agents, and MCP has become the dominant interoperability pattern for connecting assistants to data and tools.
- **Open and self-hosted models** - Llama, Mistral, Qwen, DeepSeek, and other open-weight families remain important when data residency, cost control, or offline deployment matters.

### 🚀 Frameworks to Evaluate First
- **LangGraph** - Best default for explicit, stateful, durable agent workflows with interrupts, checkpointing, streaming, and human-in-the-loop control.
- **CrewAI** - Fast path for role-based crews and business-process automation; current docs emphasize agents, crews, flows, memory, knowledge, guardrails, and observability.
- **LlamaIndex Workflows / Agents** - Strong choice for document-centric, retrieval-heavy, and event-driven workflows.
- **Microsoft Agent Framework** - Recommended Microsoft path for new .NET/Python agent projects; use AutoGen mainly for existing projects or research compatibility.
- **Google ADK** - Good fit for Gemini/Google Cloud deployments, but designed to be model- and deployment-agnostic.
- **PydanticAI** - Type-safe Python agents and structured outputs with Pydantic-native ergonomics.
- **Smolagents** - Lightweight Hugging Face framework for quick prototypes, local models, and educational examples.
- **DSPy** - Optimization-first framework for prompts, retrieval pipelines, and programmatic LM systems.

### 🛠️ Tools & Standards That Matter Now
- **Model Context Protocol (MCP)** - Standardizes how agents connect to files, APIs, databases, SaaS tools, and custom enterprise context.
- **Agent-to-Agent (A2A) patterns** - Increasingly important for cross-runtime and cross-vendor collaboration between specialized agents.
- **Observability and evals** - LangSmith, Weave, Braintrust, Phoenix, Langfuse, Arize, Helicone, and AgentOps are now table stakes for production agents.
- **Safety and governance** - Add prompt-injection testing, tool allowlists, sandboxing, secrets isolation, audit logs, and human approval for irreversible actions.
- **Durable execution** - Use Temporal, Step Functions, Durable Functions, LangGraph persistence, or equivalent workflow engines for long-running agents.

### ✅ Practical 2026 Stack Recommendations
- **Prototype quickly**: CrewAI, Google ADK, Smolagents, or OpenAI Agents SDK.
- **Production orchestration**: LangGraph, Microsoft Agent Framework, Temporal-backed workflows, or Google ADK on Vertex/Gemini Enterprise.
- **Document/RAG agents**: LlamaIndex, LangChain/LangGraph, Haystack, Ragas, and a managed or self-hosted vector store.
- **Enterprise integrations**: MCP servers, OpenAI/Anthropic/Google/Microsoft cloud connectors, identity-aware access controls, and SIEM-friendly logs.
- **Coding agents**: GitHub Copilot, Cursor, Windsurf, Aider, Continue, OpenAI Codex-style workflows, and repository-scoped MCP servers.

---

## 🛠️ Top Frameworks & Tools

### 🚀 **Production-Ready Frameworks**

| Framework | Best For | Difficulty | Multi-Agent | Links | 2026 Note |
|-----------|----------|------------|-------------|-------|-----------|
| **🕸️ LangGraph** | Durable stateful workflows | Medium | Excellent | [Site](https://www.langchain.com/langgraph) \| [GitHub](https://github.com/langchain-ai/langgraph) | Prefer for explicit graph control, checkpointing, interrupts, streaming, and long-running agents. |
| **🦜 LangChain** | RAG, tools, app glue | Easy | Via LangGraph | [Site](https://langchain.com/) \| [GitHub](https://github.com/langchain-ai/langchain) | Use LangChain integrations with LangGraph for serious orchestration. |
| **🧩 Microsoft Agent Framework** | Enterprise .NET/Python agents | Medium | Excellent | [Docs](https://learn.microsoft.com/en-us/agent-framework/) \| [GitHub](https://github.com/microsoft/agent-framework) | Successor path for new Microsoft agent projects that previously used AutoGen or Semantic Kernel. |
| **🤖 AutoGen** | Existing/research multi-agent apps | Medium | Excellent | [GitHub](https://github.com/microsoft/autogen) \| [Docs](https://microsoft.github.io/autogen/) | Use for existing systems; evaluate Microsoft Agent Framework for new production builds. |
| **⚡ CrewAI** | Role-based crews and flows | Easy | Excellent | [Site](https://crewai.com/) \| [GitHub](https://github.com/crewAIInc/crewAI) | Strong for business workflow automation with crews, flows, guardrails, memory, and observability. |
| **🦙 LlamaIndex** | Document/RAG agents | Medium | Good | [Site](https://www.llamaindex.ai/) \| [GitHub](https://github.com/run-llama/llama_index) | Best fit for parsing, indexing, retrieval, and event-driven document workflows. |
| **🔎 Google ADK** | Gemini/Google Cloud agents | Medium | Excellent | [Docs](https://adk.dev/) \| [Cloud Docs](https://docs.cloud.google.com/gemini-enterprise-agent-platform/build/adk) | Code-first, multi-language framework for enterprise-scale agents. |
| **🎯 PydanticAI** | Type-safe Python agents | Easy | Good | [Site](https://ai.pydantic.dev/) \| [GitHub](https://github.com/pydantic/pydantic-ai) | Good when structured outputs, validation, and testability matter. |
| **🪶 Smolagents** | Lightweight/local prototypes | Easy | Basic | [Docs](https://huggingface.co/docs/smolagents) \| [GitHub](https://github.com/huggingface/smolagents) | Minimalist framework for quickly wiring tools and local/open models. |
| **📐 DSPy** | Optimized LM pipelines | Hard | Limited | [GitHub](https://github.com/stanfordnlp/dspy) \| [Docs](https://dspy.ai/) | Use for systematic prompt/program optimization rather than general orchestration. |

### 🌟 **Emerging Technologies**

- **[Model Context Protocol (MCP)](https://modelcontextprotocol.io/)** - Open standard for connecting agent clients to external data, tools, and systems.
- **[OpenAI Agents SDK](https://openai.github.io/openai-agents-python/)** - Runtime for agent loops, tools, handoffs, tracing, and guardrails on top of OpenAI models.
- **[Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/)** - Unified .NET/Python framework for production-grade single-agent and multi-agent workflows.
- **[Google Agent Development Kit (ADK)](https://adk.dev/)** - Multi-language, code-first framework for building, debugging, evaluating, and deploying agents.
- **[Deep Agents](https://github.com/langchain-ai/deepagents)** - LangChain ecosystem framework for complex planning and subagent patterns.
- **[LlamaIndex Workflows](https://docs.llamaindex.ai/en/stable/module_guides/workflow/)** - Event-driven orchestration for document-heavy and RAG-heavy agent systems.
- **[Mem0](https://github.com/mem0ai/mem0)** - Long-term memory layer for personalized and multi-session AI agents.
- **[Instructor](https://github.com/jxnl/instructor)** - Structured outputs from LLMs using Python type annotations.
- **[Agency Swarm](https://github.com/VRSEN/agency-swarm)** - Framework for collaborative AI agent teams with specialized roles.
- **[Temporal](https://temporal.io/)** - Durable execution engine for long-running, retryable agent workflows.
- **[AgentOps](https://github.com/AgentOps-AI/agentops)** - Production monitoring and observability for AI agents.
- **[Rivet](https://github.com/Ironclad/rivet)** - Visual programming environment for AI agents and chains.

### 🏢 **Enterprise Platforms**

- **[OpenAI Responses API](https://platform.openai.com/docs/api-reference/responses)** - OpenAI's primary API for tool-calling, built-in tools, and agentic interactions.
- **[OpenAI Agents SDK](https://developers.openai.com/api/docs/guides/agents)** - Higher-level agent runtime for handoffs, tracing, and guardrails.
- **[Google Vertex AI Agent Builder / Gemini Enterprise Agent Platform](https://cloud.google.com/vertex-ai/docs/agent-builder)** - Google Cloud platform for enterprise conversational and workflow agents.
- **[Microsoft Copilot Studio](https://www.microsoft.com/en-us/microsoft-copilot/copilot-studio)** - Low-code agent development for Microsoft 365 and enterprise processes.
- **[Microsoft Agent Framework](https://learn.microsoft.com/en-us/agent-framework/)** - Code-first production orchestration for Microsoft-aligned .NET/Python agent systems.
- **[Amazon Bedrock Agents](https://aws.amazon.com/bedrock/agents/)** - AWS-native agent service with multiple foundation model providers and enterprise integrations.
- **[Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/)** - Azure platform for model selection, agent development, evaluation, and governance.
- **[Anthropic Claude API](https://docs.anthropic.com/)** - Strong tool-use and computer-use capabilities for agent workflows.
- **[GitHub Copilot](https://github.com/features/copilot)** - AI coding assistant and coding-agent workflows for software teams.
- **[Databricks Mosaic AI](https://www.databricks.com/product/machine-learning/mosaic-ai)** - Enterprise data and AI platform for retrieval, model serving, and agent applications.
- **[Hugging Face Agents / Smolagents](https://huggingface.co/docs/smolagents)** - Open-source agent tooling with local and hosted model options.
- **[OpenRouter](https://openrouter.ai/)** - Unified API for routing across many commercial and open model providers.

**[Explore All 40+ Frameworks →](./frameworks/README.md)**

---

## 📂 Repository Structure

```
awesome-agentic-ai/
├── 📚 tutorials/           # Step-by-step learning materials
│   ├── beginner/          # Getting started guides
│   ├── intermediate/      # Advanced concepts
│   └── advanced/          # Expert-level content
├── 🛠️ frameworks/          # Framework-specific guides
│   ├── langchain/         # LangChain resources
│   ├── autogen/           # AutoGen materials
│   ├── crewai/            # CrewAI examples
│   └── [more frameworks]  # Additional frameworks
├── 🚀 examples/            # Real-world projects
│   ├── personal-assistant/        # Daily productivity agents
│   ├── research-agent/            # Academic research automation
│   ├── coding-agent/              # Development assistance
│   ├── multi-agent-collab/        # Collaborative systems
│   ├── agent-patterns-2026/       # February 2026 patterns
│   └── agent-patterns-march-2026/ # March 2026 patterns 🆕
├── 📖 resources/           # Learning materials
│   ├── papers/            # Academic research
│   ├── cheat-sheets/      # Quick references
│   ├── roadmaps/          # Learning paths
│   └── tools/             # Utilities and helpers
├── 🔧 tools/               # CLI tools and utilities
├── 📋 CONTRIBUTING.md      # Contribution guidelines
└── 📝 README.md           # This file
```

---

## 🎯 Example Use Cases

### 🤖 **Personal Assistant Agent**
Build an AI assistant that manages your calendar, emails, and daily tasks.
- 📅 **Calendar Management**: Schedule meetings, avoid conflicts
  - **Real Example**: Reclaim.ai uses agents to automatically defend focus time and schedule smart meetings
- 📧 **Email Processing**: Prioritize, categorize, and draft responses  
  - **Real Example**: Superhuman's AI triage automatically sorts emails by importance and drafts contextual replies
- 📝 **Task Automation**: Create to-do lists, set reminders
  - **Real Example**: Motion.app uses AI agents to automatically schedule tasks based on deadlines and priorities
- **[View Example →](./examples/personal-assistant/)**

### 🔬 **Research Agent**
Automate literature reviews and research processes.
- 📚 **Paper Discovery**: Find relevant academic papers
  - **Real Example**: Consensus.app uses agents to search 200M+ papers and extract key findings automatically
- 📊 **Data Analysis**: Extract insights from research data
  - **Real Example**: Elicit.ai helps researchers analyze claims across multiple papers with AI reasoning
- 📋 **Report Generation**: Create comprehensive research summaries
  - **Real Example**: SciSpace Copilot generates literature reviews and explains complex papers in simple terms
- **[View Example →](./examples/research-agent/)**

### 💻 **Coding Agent**
AI-powered development assistant for software projects.
- 🐛 **Bug Detection**: Identify and suggest fixes for code issues
  - **Real Example**: GitHub Copilot Workspace automatically creates PRs with bug fixes across entire repositories
- 📝 **Documentation**: Auto-generate API docs and comments
  - **Real Example**: Mintlify uses agents to generate and maintain technical documentation from code
- 🔍 **Code Review**: Automated quality assessment and suggestions
  - **Real Example**: Codium AI provides context-aware code reviews and generates meaningful tests
- **[View Example →](./examples/coding-agent/)**

### 🤝 **Multi-Agent Collaboration**
Systems where specialized agents work together.
- 👥 **Software Dev Team**: Agents for different development roles
  - **Real Example**: Devin AI simulates an entire engineering team with specialized agents for frontend, backend, testing, and DevOps
- 🎭 **Role Specialization**: Each agent has specific expertise
  - **Real Example**: ChatDev creates a virtual software company where agents take roles like CEO, CTO, designer, and developer
- 🔄 **Workflow Orchestration**: Coordinated task execution
  - **Real Example**: AutoGPT orchestrates multiple agents to complete complex tasks like market research and competitor analysis
- **[View Example →](./examples/multi-agent-collab/)**

### 💼 **Enterprise Customer Service**
AI agents handling customer inquiries at scale.
- 🎧 **24/7 Support**: Automated customer assistance
  - **Real Example**: Intercom's Fin resolves 50% of support tickets instantly using GPT-4 powered agents
- 🔍 **Intelligent Routing**: Direct queries to right department
  - **Real Example**: Zendesk AI agents automatically categorize and route tickets based on content analysis
- 📊 **Analytics & Insights**: Track customer sentiment and trends
  - **Real Example**: Ada's AI agents handle 4M+ conversations monthly, providing real-time business insights

### 🏥 **Healthcare Applications**
Medical AI agents assisting healthcare professionals.
- 📋 **Clinical Documentation**: Automated medical note-taking
  - **Real Example**: Nuance DAX uses agents to convert doctor-patient conversations into clinical documentation
- 💊 **Medication Management**: Drug interaction checking and recommendations
  - **Real Example**: K Health's AI agents provide symptom checking and treatment recommendations
- 🔬 **Research & Diagnosis**: Assist in medical research and diagnosis
  - **Real Example**: Google's Med-PaLM 2 agents assist doctors with medical question answering and research

---

## 🚀 Quick Start

### 🎯 **One-Command Setup**
Get started instantly with our automated setup script:
```bash
curl -sSL https://raw.githubusercontent.com/yadavanujkumar/awesome-agentic-ai/main/scripts/setup.sh | bash
```
This script creates a complete development environment with all frameworks, examples, and tools ready to use!

### 📦 **Manual Installation**

### 1. **Choose Your Framework**
```bash
# For beginners - start with LangChain
pip install langchain langchain-community langchain-openai langgraph

# For multi-agent systems - try AutoGen  
pip install autogen-agentchat==0.7.0 autogen-ext

# For role-based agents - use CrewAI
pip install crewai==1.1.0 crewai-tools

# For data-heavy applications - use LlamaIndex
pip install llama-index==0.14.0 llama-index-core

# For type-safe agents - try PydanticAI
pip install pydantic-ai==0.6.0

# For lightweight agents - use Smolagents
pip install smolagents==2.1.0

# For monitoring and observability
pip install langfuse==4.5.0 agentops==2.0.0
```

### 2. **Build Your First Agent**

**Example 1: Customer Support Agent (Production-Ready)**
```python
# Modern LangChain + LangGraph agent example
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
from langchain_core.tools import tool
from langchain_community.tools import DuckDuckGoSearchRun

@tool
def search_knowledge_base(query: str) -> str:
    """Search company knowledge base for relevant information."""
    # In production: connect to your vector database (Pinecone, Weaviate, etc.)
    knowledge = {
        "refund": "Refunds are processed within 5-7 business days to original payment method",
        "shipping": "Standard shipping takes 3-5 days, Express 1-2 days",
        "returns": "Returns accepted within 30 days with original receipt"
    }
    for key, value in knowledge.items():
        if key in query.lower():
            return value
    return "Please contact our support team for more information"

@tool
def check_order_status(order_id: str) -> str:
    """Check the current status of a customer order."""
    # In production: connect to your order management system
    # This is a realistic example of what e-commerce agents do
    orders = {
        "ORD-12345": "Shipped - Expected delivery Mar 12, 2026",
        "ORD-67890": "Processing - Will ship within 24 hours"
    }
    return orders.get(order_id, "Order not found. Please verify order number.")

# Create customer support agent
llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)  # Cost-effective for production
tools = [search_knowledge_base, check_order_status, DuckDuckGoSearchRun()]
agent = create_react_agent(llm, tools)

# Real customer query example
result = agent.invoke({
    "messages": [("user", "Hi, I need to check my order ORD-12345 and learn about your return policy")]
})
print(result['messages'][-1].content)
# Output: "Your order ORD-12345 has been shipped and is expected to be delivered on Feb 15, 2026. 
#          Regarding our return policy, we accept returns within 30 days with the original receipt."
```

**Example 2: Simple Calculator Agent**
```python
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
from langchain_core.tools import tool

@tool
def calculator(expression: str) -> str:
    """Evaluate a mathematical expression safely."""
    try:
        # Use ast.literal_eval for safer evaluation
        # Only allow basic arithmetic operations
        import ast
        import operator
        
        ops = {
            ast.Add: operator.add,
            ast.Sub: operator.sub,
            ast.Mult: operator.mul,
            ast.Div: operator.truediv,
        }
        
        def eval_expr(node):
            if isinstance(node, ast.Num):
                return node.n
            elif isinstance(node, ast.BinOp):
                return ops[type(node.op)](eval_expr(node.left), eval_expr(node.right))
            else:
                raise ValueError(f"Unsupported operation: {node}")
        
        node = ast.parse(expression, mode='eval')
        return str(eval_expr(node.body))
    except Exception as e:
        return f"Error: {str(e)}"

# Create and run agent
llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
agent = create_react_agent(llm, [calculator])
result = agent.invoke({"messages": [("user", "What is 25 * 4 + 10?")]})
```

**Example 3: Real-World Sales Agent**
```python
from pydantic_ai import Agent, RunContext
from dataclasses import dataclass

@dataclass
class SalesContext:
    customer_name: str
    previous_purchases: list[str]
    budget: float

# Type-safe agent with structured outputs (v0.1.0+)
sales_agent = Agent(
    'openai:gpt-4o-mini',
    system_prompt="""You are a helpful sales assistant. 
    Recommend products based on customer history and budget.
    Always be personalized and respectful.""",
    deps_type=SalesContext
)

@sales_agent.tool
def check_inventory(ctx: RunContext[SalesContext], product: str) -> dict:
    """Check product availability and pricing."""
    # In production: connect to inventory management system
    # This mirrors how companies like Amazon use agents
    inventory = {
        "laptop": {"available": True, "price": 1200, "stock": 15},
        "headphones": {"available": True, "price": 150, "stock": 50},
        "keyboard": {"available": False, "price": 80, "stock": 0}
    }
    return inventory.get(product.lower(), {"available": False, "price": 0, "stock": 0})

# Use the agent
context = SalesContext(
    customer_name="Sarah",
    previous_purchases=["mouse", "monitor"],
    budget=1500
)
result = sales_agent.run_sync(
    "I'm looking for a laptop for work and maybe some headphones",
    deps=context
)
print(result.data)
```

**Alternative: PydanticAI (Type-Safe) - Production Example**
```python
from pydantic_ai import Agent
from pydantic import BaseModel

class MathResult(BaseModel):
    """Structured output for calculations"""
    expression: str
    result: float
    explanation: str

# Type-safe agent with structured outputs (v0.1.0+)
# Used by fintech companies for reliable financial calculations
agent = Agent(
    'openai:gpt-4o-mini',
    result_type=MathResult,
    system_prompt='You are a helpful math assistant. Always show your work.'
)

result = agent.run_sync('What is 25 * 4 + 10?')
print(f"Result: {result.data.result}")  # 110
print(f"Explanation: {result.data.explanation}")
# Output structured data: {"expression": "25 * 4 + 10", "result": 110.0, "explanation": "First multiply 25 by 4 to get 100, then add 10"}
```

**Alternative: Smolagents (Lightweight) - Privacy-Focused Example**
```python
from smolagents import CodeAgent, DuckDuckGoSearchTool, HfApiModel

# Lightweight agent with open models - perfect for privacy-conscious deployments
# Used by companies requiring on-premise solutions
agent = CodeAgent(
    tools=[DuckDuckGoSearchTool()],
    model=HfApiModel()  # Uses Hugging Face models - can run locally
)

# Real-world query example
result = agent.run("""
    Search for the latest developments in agentic AI as of July 2026.
    Summarize the top 3 most important updates.
""")
print(result)
# Agent will search, analyze results, and provide a structured summary
```

### 3. **Explore Examples**
- Browse the [`examples/`](./examples/) directory
- Start with simple use cases that match your needs
- Follow the setup instructions in each project

### 4. **Join the Community**
- ⭐ Star this repository to stay updated
- 🐛 Report issues or suggest improvements
- 🤝 Contribute your own examples and tutorials
- 💬 Join discussions in our [GitHub Discussions](https://github.com/yadavanujkumar/Agentic-AI-Resources/discussions)

---

## 📚 Curated Learning Resources

### 📖 **Essential Papers & Technical References**
- [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629)
- [Toolformer: Language Models Can Teach Themselves to Use Tools](https://arxiv.org/abs/2302.04761)
- [HuggingGPT: Solving AI Tasks with ChatGPT and its Friends](https://arxiv.org/abs/2303.17580)
- [MetaGPT: Meta Programming for Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352)
- [AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation](https://arxiv.org/abs/2308.08155)
- [AgentBench: Evaluating LLMs as Agents](https://arxiv.org/abs/2308.03688) - Comprehensive agent evaluation framework
- [The Rise and Potential of Large Language Model Based Agents](https://arxiv.org/abs/2309.07864) - Survey of LLM-based agents
- [Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) - Self-reflective reasoning
- [Tree of Thoughts: Deliberate Problem Solving](https://arxiv.org/abs/2305.10601) - Advanced reasoning technique
- [AgentGym: Evolving LLM-based Agents across Diverse Environments](https://arxiv.org/abs/2406.04151) - Agent training and evaluation
- [AutoWebGLM: Web Navigating Agents](https://arxiv.org/abs/2404.03648) - Web automation capabilities
- [Agent-Pro: Learning to Evolve via Policy-Level Reflection](https://arxiv.org/abs/2402.17574) - Self-improving agents
- [Executable Code Actions Elicit Better LLM Agents](https://arxiv.org/abs/2402.01030) - Code-based agent actions
- [Agent-FLAN: Designing Data and Methods for Effective Agent Tuning](https://arxiv.org/abs/2403.12881) - Fine-tuning for agent behavior
- [Model Context Protocol Specification](https://modelcontextprotocol.io/specification) - Interoperability standard for tools and context
- [OpenAI Agents SDK Documentation](https://openai.github.io/openai-agents-python/) - Practical runtime reference for agent loops and handoffs
- **[130+ More Papers →](./resources/README.md#📚-academic-papers)**

### 🎥 **Video Tutorials & Channels**
- **[Two Minute Papers](https://www.youtube.com/@TwoMinutePapers)** - Latest AI research explained
- **[LangChain Official](https://www.youtube.com/@LangChain)** - Framework tutorials and guides
- **[Microsoft AutoGen](https://www.youtube.com/@MicrosoftDeveloper)** - Multi-agent system tutorials
- **[Yannic Kilcher](https://www.youtube.com/@YannicKilcher)** - Deep paper reviews and explanations
- **[AI Explained](https://www.youtube.com/@aiexplained-official)** - AI concepts simplified
- **[100+ Channels & Playlists →](./resources/README.md#🎥-video-resources)**

### 📚 **Books & Reading Materials**
- **[Artificial Intelligence: A Modern Approach (4th Edition)](https://www.amazon.com/Artificial-Intelligence-Modern-Approach-4th/dp/0134610997)** by Russell & Norvig
- **[Multi-Agent Systems: Algorithmic, Game-Theoretic, and Logical Foundations](https://www.amazon.com/Multi-Agent-Systems-Algorithmic-Game-Theoretic-Foundations/dp/0521899435)** by Shoham & Leyton-Brown
- **[Building LLM Applications for Production](https://www.amazon.com/Building-LLM-Applications-Production-Huyen/dp/1098150961)** by Chip Huyen
- **[Hands-On Large Language Models](https://www.amazon.com/Hands-Large-Language-Models-Understanding/dp/1098150952)** by Jay Alammar & Maarten Grootendorst
- **[15+ More Books with Links →](./resources/README.md#📖-recommended-books)**

### 🎓 **Courses & Certifications**
- **[DeepLearning.AI AI Agentic Workflows Specialization](https://www.coursera.org/specializations/ai-agentic-workflows)** - Comprehensive agentic AI specialization
- **[LangChain Academy](https://academy.langchain.com/)** - Official LangChain and LangGraph learning materials
- **[Google Cloud Skills Boost](https://www.cloudskillsboost.google/)** - Vertex AI, Gemini, and agent-builder labs
- **[Microsoft Learn: Azure AI and Agent Framework](https://learn.microsoft.com/en-us/agent-framework/)** - Microsoft agent framework and Azure AI learning path entry point
- **[AWS Skill Builder](https://skillbuilder.aws/)** - Bedrock, generative AI, and ML training
- **[Hugging Face Learn](https://huggingface.co/learn)** - Open-source model and agent development courses
- **[Anthropic Prompt Engineering Course](https://github.com/anthropics/courses)** - Advanced prompting and tool-use foundations
- **[Stanford CS224N: NLP with Deep Learning](https://www.youtube.com/playlist?list=PLoROMvodv4rOSH4v6133s9LFPRHjEmbmJ)** - Advanced NLP concepts
- **[Berkeley CS285: Deep RL](https://www.youtube.com/playlist?list=PL_iWQOsE6TfXxKgI1GgyV1B_Xa0DxE5eH)** - Reinforcement learning for agents
- **[35+ More Courses →](./resources/README.md#🎓-certification-programs--learning-paths)**

### 🛠️ **Development Tools & Platforms**
- **[LangSmith](https://smith.langchain.com/)** - Debug, evaluate, and monitor LangChain/LangGraph applications with production tracing
- **[LangGraph Studio](https://studio.langchain.com/)** - Visual IDE for building and debugging stateful agent workflows
- **[OpenAI Agents SDK](https://openai.github.io/openai-agents-python/)** - Agent runtime with tracing, guardrails, tools, and handoffs
- **[Model Context Protocol (MCP)](https://modelcontextprotocol.io/)** - Standard protocol for tool/context integration
- **[Weights & Biases Weave](https://wandb.ai/site/weave)** - LLM tracing, evaluation pipelines, and agent quality workflows
- **[Braintrust](https://www.braintrustdata.com/)** - AI product development platform with evals and logging
- **[Phoenix / Arize](https://phoenix.arize.com/)** - AI observability and LLM evaluation platform
- **[Langfuse](https://langfuse.com/)** - Open-source LLM observability with traces, prompts, and evals
- **[Helicone](https://www.helicone.ai/)** - LLM observability and cost monitoring
- **[Cursor](https://cursor.sh/)** - AI-first code editor with repository-aware agent workflows
- **[GitHub Copilot](https://github.com/features/copilot)** - Multi-model AI coding assistant and coding-agent workflows
- **[Replit Agent](https://replit.com/ai)** - Browser-based agent for complete application development
- **[v0.dev](https://v0.dev/)** - Vercel's AI interface and UI generation agent
- **[Bolt.new](https://bolt.new/)** - AI-powered full-stack web development in browser
- **[Windsurf](https://windsurf.com/)** - AI-first IDE with agentic software-development flows
- **[Aider](https://aider.chat/)** - AI pair programming in the terminal with repository awareness
- **[Continue.dev](https://continue.dev/)** - Open-source AI coding assistant with custom model support
- **[PromptLayer](https://promptlayer.com/)** - Prompt engineering and management platform

---

## 🤝 Contributing

We welcome contributions from the community! Whether you want to:

- 📚 **Add tutorials** or learning materials
- 🚀 **Share example projects** you've built
- 🐛 **Fix bugs** or improve documentation
- 💡 **Suggest new features** or frameworks

Please see our **[Contributing Guide](./CONTRIBUTING.md)** for detailed instructions.

### Quick Contribution Steps:
1. 🍴 Fork this repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-addition`)
3. ✨ Make your changes and add tests if applicable
4. 💬 Commit your changes (`git commit -m 'Add amazing feature'`)
5. 📤 Push to the branch (`git push origin feature/amazing-addition`)
6. 🔄 Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](./LICENSE) file for details.

---

## ⭐ Show Your Support

If this repository helps you in your Agentic AI journey, please give it a star! ⭐

It helps others discover this resource and motivates us to keep improving it.

---

## 📞 Connect & Stay Updated

- 🐙 **GitHub**: [yadavanujkumar](https://github.com/yadavanujkumar)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yadavanujkumar/awesome-agentic-ai/discussions)
- 🐛 **Issues**: [Report bugs or request features](https://github.com/yadavanujkumar/awesome-agentic-ai/issues)
- 📚 **Resources**: [Complete Resource Guide](./resources/README.md)
- 🛠️ **Tools**: [Development Tools & Utilities](./tools/README.md)
- 🏗️ **Frameworks**: [Framework Comparison Guide](./frameworks/README.md)

### 🔗 Quick Links
- **[📊 Cheat Sheets](./resources/cheat-sheets/)** - Agent patterns, prompting, tools, communication, 2025 patterns, enterprise deployment
- **[🎥 Video Tutorials](./resources/README.md#🎥-video-resources)** - 150+ YouTube channels and playlists
- **[📚 Books & Courses](./resources/README.md#📖-recommended-books)** - Comprehensive learning materials
- **[🏆 Competitions](./resources/README.md#🏆-competitions-and-challenges)** - Active challenges and events
- **[🔧 Development Tools](./tools/README.md#🛠️-development-tools)** - Debugging, monitoring, deployment
- **[🎙️ Podcasts](./resources/README.md#🎙️-podcasts--audio-content)** - AI audio content and discussions
- **🚀 [2026 Agent Patterns](./examples/agent-patterns-2026/)** - February 2026 implementation patterns
- **🆕 [March 2026 Agent Patterns](./examples/agent-patterns-march-2026/)** - Historical 2026 implementation patterns and frameworks

### 📈 Repository Stats
- **🌟 40+ Frameworks** covered with comprehensive guides (July 2026 update)
- **📚 140+ Academic Papers** with direct links and summaries
- **🎥 160+ Video Resources** including tutorials and courses
- **📖 30+ Books** with purchase links and descriptions
- **🛠️ 100+ Tools** for development, monitoring, and deployment
- **📋 7 Comprehensive Cheat Sheets** covering all aspects of agent development
- **🏆 20+ Competitions** and active challenges
- **🌍 60+ Communities** and international events
- **🆕 Latest July 2026 Updates** - OpenAI Responses API and Agents SDK, Microsoft Agent Framework, Google ADK, MCP, LangGraph, CrewAI, LlamaIndex Workflows, observability/evals, and durable execution patterns

### 🤝 Community Contributions Welcome
We're actively looking for contributions in:
- **📝 Tutorial Content** - Step-by-step guides and examples
- **🚀 Framework Guides** - Setup and best practices for new frameworks
- **🔧 Tool Reviews** - Hands-on experience with development tools
- **🎯 Use Case Examples** - Real-world applications and implementations
- **🌍 Translations** - Making content accessible globally

---

<div align="center">

**Built with ❤️ for the Agentic AI community**

*"The future belongs to those who can build agents that think, act, and collaborate intelligently."*

[⬆ Back to Top](#-agentic-ai-resources)

</div>
