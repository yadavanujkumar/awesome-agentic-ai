# Framework Comparison Cheat Sheet

Quick reference for choosing the right Agentic AI framework for your project.

## 🏆 At a Glance

| Framework | Best For | Difficulty | Community | Multi-Agent |
|-----------|----------|------------|-----------|-------------|
| **LangChain** | General LLM apps, RAG | Easy | Largest | Limited |
| **AutoGen** | Multi-agent conversations | Medium | Growing | Excellent |
| **CrewAI** | Role-based teams | Easy | Medium | Excellent |
| **LlamaIndex** | Data & knowledge systems | Medium | Large | Limited |
| **Semantic Kernel** | Enterprise integration | Medium | Medium | Basic |
| **Haystack** | Search & QA systems | Hard | Medium | Limited |

## 🦜 LangChain

**Perfect for:**
- RAG (Retrieval Augmented Generation) systems
- Document processing and analysis
- Conversational agents with memory
- Tool integration and function calling

**Pros:**
- ✅ Extensive documentation and tutorials
- ✅ Huge ecosystem of tools and integrations
- ✅ Active community and frequent updates
- ✅ Great for beginners

**Cons:**
- ❌ Can be complex for simple tasks
- ❌ Limited multi-agent capabilities
- ❌ Sometimes over-engineered

**Code Example:**
```python
from langchain.agents import initialize_agent
from langchain.tools import Tool

agent = initialize_agent(
    tools=[Tool(name="Search", func=search_func)],
    llm=llm,
    agent="zero-shot-react-description"
)
```

---

## 🤖 AutoGen

**Perfect for:**
- Multi-agent conversations
- Code generation and review
- Collaborative problem solving
- Complex workflows with agent handoffs

**Pros:**
- ✅ Excellent multi-agent support
- ✅ Built-in conversation patterns
- ✅ Great for code generation tasks
- ✅ Clean, intuitive API

**Cons:**
- ❌ Newer framework, smaller ecosystem
- ❌ Limited single-agent capabilities
- ❌ Less documentation than LangChain

**Code Example:**
```python
import autogen

assistant = autogen.AssistantAgent("assistant")
user_proxy = autogen.UserProxyAgent("user")

user_proxy.initiate_chat(
    assistant, 
    message="Write a Python function to calculate fibonacci"
)
```

---

## ⚡ CrewAI

**Perfect for:**
- Role-playing AI teams
- Hierarchical agent structures
- Specialized workflows
- Business process automation

**Pros:**
- ✅ Intuitive role-based design
- ✅ Easy to set up agent teams
- ✅ Good documentation
- ✅ Built for collaboration

**Cons:**
- ❌ Youngest framework
- ❌ Limited advanced features
- ❌ Smaller community

**Code Example:**
```python
from crewai import Agent, Task, Crew

researcher = Agent(
    role='Researcher',
    goal='Find relevant information',
    backstory='Expert researcher...'
)

crew = Crew(agents=[researcher], tasks=[task])
```

---

## 🦙 LlamaIndex

**Perfect for:**
- Knowledge base construction
- Document indexing and retrieval
- Question answering systems
- Data-heavy applications

**Pros:**
- ✅ Excellent for data applications
- ✅ Advanced indexing capabilities
- ✅ Strong RAG support
- ✅ Good performance optimization

**Cons:**
- ❌ Steep learning curve
- ❌ Limited agent capabilities
- ❌ More focused on data than agents

**Code Example:**
```python
from llama_index import VectorStoreIndex, SimpleDirectoryReader

documents = SimpleDirectoryReader('data').load_data()
index = VectorStoreIndex.from_documents(documents)
query_engine = index.as_query_engine()
```

---

## 🧠 Semantic Kernel

**Perfect for:**
- Enterprise applications
- .NET/C# ecosystems
- Function calling and orchestration
- Microsoft ecosystem integration

**Pros:**
- ✅ Strong enterprise support
- ✅ Multi-language support (.NET, Python)
- ✅ Good integration patterns
- ✅ Microsoft backing

**Cons:**
- ❌ Smaller Python community
- ❌ More complex setup
- ❌ Limited multi-agent features

**Code Example:**
```python
import semantic_kernel as sk

kernel = sk.Kernel()
kernel.add_text_completion_service("gpt", OpenAITextCompletion("gpt-3.5-turbo"))

prompt = kernel.create_semantic_function("Summarize: {{$input}}")
```

---

## 🔍 Haystack

**Perfect for:**
- Production search systems
- Complex NLP pipelines
- Enterprise search applications
- High-performance requirements

**Pros:**
- ✅ Production-ready architecture
- ✅ High performance and scalability
- ✅ Comprehensive NLP pipeline support
- ✅ Good enterprise features

**Cons:**
- ❌ Steeper learning curve
- ❌ Overkill for simple projects
- ❌ Limited agent-specific features

**Code Example:**
```python
from haystack import Pipeline
from haystack.nodes import FARMReader, BM25Retriever

pipeline = Pipeline()
pipeline.add_node(component=retriever, name="Retriever", inputs=["Query"])
pipeline.add_node(component=reader, name="Reader", inputs=["Retriever"])
```

---

## 🎯 Decision Matrix

### Choose LangChain if:
- Building your first AI agent
- Need extensive tool integration
- Working with documents and data
- Want the largest community support

### Choose AutoGen if:
- Need multiple agents working together
- Building code generation systems
- Want conversation-driven workflows
- Comfortable with newer frameworks

### Choose CrewAI if:
- Want role-based agent teams
- Need simple multi-agent setup
- Building business workflows
- Prefer intuitive, clean APIs

### Choose LlamaIndex if:
- Working with large knowledge bases
- Need advanced data retrieval
- Building Q&A systems
- Data is your primary focus

### Choose Semantic Kernel if:
- Working in enterprise environment
- Using .NET/Microsoft stack
- Need enterprise integrations
- Building function-heavy applications

### Choose Haystack if:
- Building production search systems
- Need high performance/scalability
- Complex NLP requirements
- Enterprise search applications

---

## 🚀 Quick Start Commands

```bash
# LangChain
pip install langchain langchain-community langchain-openai

# AutoGen
pip install autogen-agentchat

# CrewAI
pip install crewai

# LlamaIndex
pip install llama-index

# Semantic Kernel
pip install semantic-kernel

# Haystack
pip install farm-haystack
```

---

## 💡 Pro Tips

1. **Start Simple**: Begin with LangChain for learning, then specialize
2. **Multi-Agent**: AutoGen or CrewAI for agent collaboration
3. **Data-Heavy**: LlamaIndex for knowledge-intensive applications
4. **Enterprise**: Semantic Kernel for business applications
5. **Performance**: Haystack for production search systems

---

## 🔄 Framework Migration

Moving between frameworks is common as your needs evolve:

- **LangChain → AutoGen**: When you need multi-agent capabilities
- **AutoGen → CrewAI**: When you want simpler role-based agents
- **LangChain → LlamaIndex**: When data becomes your primary focus
- **Any → Semantic Kernel**: When moving to enterprise deployment

Remember: You can also combine frameworks in the same project!