# Beginner Tutorials

Welcome to the beginner-friendly tutorials for Agentic AI! These step-by-step guides will take you from zero to building your first AI agent.

## 🎯 Learning Path

### Tutorial 1: Introduction to AI Agents
**Duration**: 1-2 hours  
**Prerequisites**: Basic Python knowledge

Learn the fundamental concepts of AI agents and build your first simple agent.

- [📖 Read Tutorial](./01-introduction-to-agents/)
- [📓 Jupyter Notebook](./01-introduction-to-agents/tutorial.ipynb)
- [💻 Code Examples](./01-introduction-to-agents/examples/)

**What you'll learn:**
- What are AI agents and how they work
- Key components: LLM, memory, tools, and planning
- Overview of major frameworks (LangChain, AutoGen, CrewAI, OpenAI Swarm)
- Building a basic conversational agent
- Testing and debugging your agent
- 2025 developments in agentic AI

---

### Tutorial 2: Building Your First Agent with LangChain
**Duration**: 2-3 hours  
**Prerequisites**: Tutorial 1

Create a practical AI agent using LangChain framework with real tools.

- [📖 Read Tutorial](./02-first-agent-langchain/)
- [📓 Jupyter Notebook](./02-first-agent-langchain/tutorial.ipynb)
- [💻 Code Examples](./02-first-agent-langchain/examples/)

**What you'll learn:**
- Setting up LangChain development environment (2025 version)
- Introduction to LangGraph for stateful agents
- Creating agents with tool usage capabilities
- Integrating web search and calculator tools
- Adding conversation memory with LangSmith monitoring
- Error handling and safety measures
- Alternative approaches with OpenAI Swarm

---

### Tutorial 3: Agent Memory and State Management
**Duration**: 2-3 hours  
**Prerequisites**: Tutorial 2

Learn how to give your agents memory and manage conversation state effectively.

- [📖 Read Tutorial](./03-memory-and-state/)
- [📓 Jupyter Notebook](./03-memory-and-state/tutorial.ipynb)
- [💻 Code Examples](./03-memory-and-state/examples/)

**What you'll learn:**
- Different types of memory systems
- Conversation buffer vs. summary memory
- Persistent memory with vector databases
- Context window management
- Best practices for state handling

---

### Tutorial 4: Tool Integration and Function Calling
**Duration**: 3-4 hours  
**Prerequisites**: Tutorial 3

Expand your agent's capabilities by integrating external tools and APIs.

- [📖 Read Tutorial](./04-tool-integration/)
- [📓 Jupyter Notebook](./04-tool-integration/tutorial.ipynb)
- [💻 Code Examples](./04-tool-integration/examples/)

**What you'll learn:**
- Creating custom tools for your agent
- API integration patterns
- File system operations
- Database connectivity
- Tool selection and routing
- Error handling for external services

---

### Tutorial 5: Prompt Engineering for Agents
**Duration**: 2-3 hours  
**Prerequisites**: Tutorial 4

Master the art of prompt engineering to make your agents more effective.

- [📖 Read Tutorial](./05-prompt-engineering/)
- [📓 Jupyter Notebook](./05-prompt-engineering/tutorial.ipynb)
- [💻 Code Examples](./05-prompt-engineering/examples/)

**What you'll learn:**
- Effective prompting strategies for agents
- Chain-of-thought reasoning
- Few-shot examples and templates
- System prompts vs. user prompts
- Testing and iterating on prompts

---

### Tutorial 6: Deploying Your First Agent
**Duration**: 3-4 hours  
**Prerequisites**: Tutorial 5

Learn how to deploy your agent for real-world use.

- [📖 Read Tutorial](./06-deployment/)
- [📓 Jupyter Notebook](./06-deployment/tutorial.ipynb)
- [💻 Code Examples](./06-deployment/examples/)

**What you'll learn:**
- Packaging your agent application
- Environment configuration and secrets management
- Web interface creation with Streamlit
- Basic monitoring and logging
- Docker containerization
- Simple cloud deployment options

---

## 🛠️ Setup Instructions

### Prerequisites
- Python 3.8 or higher
- Basic understanding of Python programming
- Text editor or IDE (VS Code recommended)
- Git for version control

### Environment Setup
```bash
# Clone the repository
git clone https://github.com/yadavanujkumar/Agentic-AI-Resources.git
cd Agentic-AI-Resources/tutorials/beginner

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env file with your API keys
```

### Required API Keys
- **OpenAI API Key**: Get from [OpenAI Platform](https://platform.openai.com/)
- **Other APIs**: Specific tutorials may require additional keys (all free tiers available)

## 📚 Tutorial Format

Each tutorial includes:
- **README.md**: Step-by-step written instructions
- **tutorial.ipynb**: Interactive Jupyter notebook
- **examples/**: Complete code examples
- **exercises/**: Practice problems and solutions
- **resources/**: Additional reading and references

## 🎯 Learning Objectives

By completing these tutorials, you will:
- ✅ Understand core concepts of AI agents
- ✅ Build functional agents using LangChain
- ✅ Integrate external tools and APIs
- ✅ Implement memory and state management
- ✅ Deploy agents for real-world use
- ✅ Apply best practices for agent development

## 🚀 Next Steps

After completing these tutorials:
1. **Intermediate Tutorials**: Explore multi-agent systems and advanced patterns
2. **Example Projects**: Try building the personal assistant or research agent
3. **Framework Exploration**: Learn AutoGen, CrewAI, or other frameworks
4. **Community Participation**: Join discussions and contribute back

## 💡 Tips for Success

- **Practice Regularly**: Build small agents frequently
- **Experiment**: Try different approaches and configurations
- **Read Documentation**: Familiarize yourself with framework docs
- **Join Community**: Ask questions and share your progress
- **Start Simple**: Master basics before moving to complex scenarios

## 🤝 Getting Help

- **Questions**: Open an issue in the main repository
- **Discussions**: Use GitHub Discussions for broader topics
- **Community**: Join our Discord server (link in main README)
- **Office Hours**: Monthly community Q&A sessions



---

**Ready to start? Begin with [Tutorial 1: Introduction to AI Agents](./01-introduction-to-agents/)**

Happy learning! 🚀