# Tutorial 2: Building Your First Agent with LangChain

**Duration**: 2-3 hours  
**Prerequisites**: [Tutorial 1: Introduction to AI Agents](../01-introduction-to-agents/)  
**Goal**: Create a practical AI agent using LangChain framework with real tools

## 🎯 Learning Objectives

After completing this tutorial, you will:
- Set up LangChain development environment
- Create agents with tool usage capabilities
- Integrate web search and calculator tools
- Add conversation memory
- Implement error handling and safety measures

---

## 🦜 Introduction to LangChain

LangChain is a powerful framework for building applications with large language models. It provides:

- **Modular Components**: Chains, agents, tools, memory systems
- **Built-in Tools**: Web search, calculators, databases, APIs
- **Agent Types**: ReAct, conversational, planning agents
- **Memory Management**: Conversation buffers, summaries, vector stores

### Why LangChain for Agents?

1. **Rich Ecosystem**: Pre-built tools and integrations
2. **Flexible Architecture**: Easy to customize and extend
3. **Production Ready**: Monitoring, debugging, deployment tools
4. **Active Community**: Regular updates and community support

---

## 🛠️ Environment Setup

### Step 1: Install Dependencies

```bash
# Create new project
mkdir langchain-agent
cd langchain-agent

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install LangChain and dependencies
pip install langchain langchain-community langchain-openai
pip install duckduckgo-search wikipedia python-dotenv
pip install streamlit  # For web interface (optional)
```

### Step 2: Environment Configuration

Create `.env` file:

```env
OPENAI_API_KEY=your_openai_api_key_here
LANGCHAIN_TRACING_V2=true
LANGCHAIN_API_KEY=your_langsmith_api_key_here  # Optional: for debugging
```

---

## 🧰 Building Your First LangChain Agent

### Step 1: Basic Agent Setup

Create `basic_agent.py`:

```python
import os
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType
from langchain_openai import ChatOpenAI
from langchain.tools import Tool
from langchain.memory import ConversationBufferMemory

# Load environment variables
load_dotenv()

def create_basic_agent():
    """Create a basic LangChain agent with simple tools"""
    
    # Initialize the LLM
    llm = ChatOpenAI(
        temperature=0.7,
        model="gpt-3.5-turbo",
        openai_api_key=os.getenv("OPENAI_API_KEY")
    )
    
    # Create simple tools
    def calculator(expression):
        """Evaluate mathematical expressions safely"""
        try:
            # Basic safety check
            allowed_chars = set('0123456789+-*/.() ')
            if all(c in allowed_chars for c in expression):
                result = eval(expression)
                return f"The answer is: {result}"
            else:
                return "Error: Invalid characters in expression"
        except Exception as e:
            return f"Error calculating: {str(e)}"
    
    def text_length(text):
        """Count characters in text"""
        return f"The text '{text}' has {len(text)} characters."
    
    # Define tools
    tools = [
        Tool(
            name="Calculator",
            func=calculator,
            description="Useful for mathematical calculations. Input should be a valid mathematical expression."
        ),
        Tool(
            name="Text Length",
            func=text_length,
            description="Count the number of characters in a given text."
        )
    ]
    
    # Add memory
    memory = ConversationBufferMemory(
        memory_key="chat_history",
        return_messages=True
    )
    
    # Create agent
    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType.CHAT_CONVERSATIONAL_REACT_DESCRIPTION,
        memory=memory,
        verbose=True,  # Shows reasoning steps
        handle_parsing_errors=True
    )
    
    return agent

def run_basic_agent():
    """Run the basic agent in a chat loop"""
    agent = create_basic_agent()
    
    print("🦜 LangChain Agent initialized!")
    print("Available tools: Calculator, Text Length")
    print("Type 'quit' to exit\n")
    
    while True:
        user_input = input("You: ").strip()
        
        if user_input.lower() in ['quit', 'exit', 'bye']:
            print("🦜 Agent: Goodbye!")
            break
            
        if not user_input:
            continue
        
        try:
            response = agent.run(user_input)
            print(f"🦜 Agent: {response}\n")
        except Exception as e:
            print(f"🦜 Agent: Sorry, I encountered an error: {str(e)}\n")

if __name__ == "__main__":
    run_basic_agent()
```

---

## 🌐 Adding Web Search Capabilities

### Step 2: Enhanced Agent with Web Search

Create `web_agent.py`:

```python
import os
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType
from langchain_openai import ChatOpenAI
from langchain.tools import DuckDuckGoSearchRun, WikipediaQueryRun
from langchain.utilities import WikipediaAPIWrapper
from langchain.memory import ConversationBufferWindowMemory

load_dotenv()

def create_web_agent():
    """Create an agent with web search capabilities"""
    
    # Initialize LLM
    llm = ChatOpenAI(
        temperature=0.7,
        model="gpt-3.5-turbo",
        openai_api_key=os.getenv("OPENAI_API_KEY")
    )
    
    # Web search tools
    search = DuckDuckGoSearchRun()
    wikipedia = WikipediaQueryRun(api_wrapper=WikipediaAPIWrapper())
    
    # Custom tools
    def weather_info(location):
        """Provide weather information disclaimer"""
        return f"I can't access real-time weather data for {location}. Please check weather.com or your local weather app for current conditions."
    
    def current_time():
        """Get current time"""
        from datetime import datetime
        return f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    
    # Tool list
    tools = [
        search,
        wikipedia,
        Tool(
            name="Weather Info",
            func=weather_info,
            description="Get weather information for a location (returns guidance to check weather apps)"
        ),
        Tool(
            name="Current Time",
            func=current_time,
            description="Get the current date and time"
        )
    ]
    
    # Memory with window (keeps last 10 interactions)
    memory = ConversationBufferWindowMemory(
        k=10,
        memory_key="chat_history",
        return_messages=True
    )
    
    # Create agent with error handling
    agent = initialize_agent(
        tools=tools,
        llm=llm,
        agent=AgentType.CHAT_CONVERSATIONAL_REACT_DESCRIPTION,
        memory=memory,
        verbose=True,
        handle_parsing_errors=True,
        max_iterations=3  # Prevent infinite loops
    )
    
    return agent

def run_web_agent():
    """Run the web-enabled agent"""
    agent = create_web_agent()
    
    print("🌐 Web-Enabled LangChain Agent initialized!")
    print("Available tools: Web Search, Wikipedia, Weather Info, Current Time")
    print("Type 'quit' to exit\n")
    
    while True:
        user_input = input("You: ").strip()
        
        if user_input.lower() in ['quit', 'exit', 'bye']:
            print("🌐 Agent: Goodbye!")
            break
            
        if not user_input:
            continue
        
        try:
            response = agent.run(user_input)
            print(f"🌐 Agent: {response}\n")
        except Exception as e:
            print(f"🌐 Agent: I encountered an error: {str(e)}")
            print("Let me try a different approach.\n")

if __name__ == "__main__":
    run_web_agent()
```

---

## 🧠 Advanced Memory Management

### Step 3: Agent with Persistent Memory

Create `memory_agent.py`:

```python
import os
import json
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType
from langchain_openai import ChatOpenAI
from langchain.tools import DuckDuckGoSearchRun, Tool
from langchain.memory import ConversationSummaryBufferMemory

load_dotenv()

class PersistentMemoryAgent:
    def __init__(self, memory_file="agent_memory.json"):
        self.memory_file = memory_file
        self.llm = ChatOpenAI(
            temperature=0.7,
            model="gpt-3.5-turbo",
            openai_api_key=os.getenv("OPENAI_API_KEY")
        )
        self.agent = self._create_agent()
        self._load_memory()
    
    def _create_agent(self):
        """Create agent with advanced memory"""
        
        # Tools
        search = DuckDuckGoSearchRun()
        
        def remember_fact(fact):
            """Store important facts in memory"""
            self._save_fact(fact)
            return f"I'll remember that: {fact}"
        
        def recall_facts():
            """Recall stored facts"""
            facts = self._load_facts()
            if facts:
                return "Here's what I remember: " + "; ".join(facts)
            return "I don't have any stored facts yet."
        
        tools = [
            search,
            Tool(
                name="Remember Fact",
                func=remember_fact,
                description="Store an important fact for later recall"
            ),
            Tool(
                name="Recall Facts",
                func=recall_facts,
                description="Retrieve previously stored facts"
            )
        ]
        
        # Advanced memory with summarization
        memory = ConversationSummaryBufferMemory(
            llm=self.llm,
            max_token_limit=1000,
            memory_key="chat_history",
            return_messages=True
        )
        
        agent = initialize_agent(
            tools=tools,
            llm=self.llm,
            agent=AgentType.CHAT_CONVERSATIONAL_REACT_DESCRIPTION,
            memory=memory,
            verbose=True,
            handle_parsing_errors=True
        )
        
        return agent
    
    def _save_fact(self, fact):
        """Save fact to persistent storage"""
        facts = self._load_facts()
        facts.append(fact)
        with open(self.memory_file, 'w') as f:
            json.dump({"facts": facts}, f)
    
    def _load_facts(self):
        """Load facts from persistent storage"""
        try:
            with open(self.memory_file, 'r') as f:
                data = json.load(f)
                return data.get("facts", [])
        except FileNotFoundError:
            return []
    
    def _load_memory(self):
        """Load conversation memory if available"""
        # This is a simplified version
        # In production, you'd want to save/load the full memory state
        pass
    
    def run(self, user_input):
        """Process user input"""
        return self.agent.run(user_input)

def run_memory_agent():
    """Run the agent with persistent memory"""
    agent = PersistentMemoryAgent()
    
    print("🧠 Memory-Enhanced LangChain Agent initialized!")
    print("I can remember facts between conversations!")
    print("Try: 'Remember that I like pizza' or 'What do you remember about me?'")
    print("Type 'quit' to exit\n")
    
    while True:
        user_input = input("You: ").strip()
        
        if user_input.lower() in ['quit', 'exit', 'bye']:
            print("🧠 Agent: Goodbye! I'll remember our conversation.")
            break
            
        if not user_input:
            continue
        
        try:
            response = agent.run(user_input)
            print(f"🧠 Agent: {response}\n")
        except Exception as e:
            print(f"🧠 Agent: Error: {str(e)}\n")

if __name__ == "__main__":
    run_memory_agent()
```

---

## 🛡️ Safety and Error Handling

### Best Practices

1. **Input Validation**: Always validate user inputs
2. **Rate Limiting**: Prevent excessive API calls
3. **Error Recovery**: Graceful handling of failures
4. **Content Filtering**: Block inappropriate content

```python
def safe_agent_wrapper(agent, user_input):
    """Wrapper for safe agent execution"""
    
    # Input validation
    if len(user_input) > 1000:
        return "Input too long. Please keep it under 1000 characters."
    
    # Basic content filtering
    blocked_words = ["hack", "exploit", "attack"]
    if any(word in user_input.lower() for word in blocked_words):
        return "I can't help with that request."
    
    # Rate limiting (implement with timestamps)
    # ...
    
    try:
        response = agent.run(user_input)
        return response
    except Exception as e:
        return f"I encountered an error. Please try rephrasing your request."
```

---

## 🧪 Testing Your Agent

### Test Scenarios

1. **Web Search**: "What's the latest news about AI?"
2. **Wikipedia**: "Tell me about Python programming language"
3. **Memory**: "Remember that I'm a software engineer"
4. **Recall**: "What do you know about me?"
5. **Error Cases**: Very long input, special characters

---

## 🎯 Exercises

### Exercise 1: Add Custom Tool
Create a tool that can read and summarize text files.

### Exercise 2: Improve Memory
Add user preferences and context awareness.

### Exercise 3: Web Interface
Create a Streamlit web interface for your agent.

### Exercise 4: Multi-turn Planning
Enable the agent to break down complex tasks into steps.

---

## 📚 Key Concepts Review

- **LangChain Framework**: Modular approach to LLM applications
- **Tools and Chains**: Extending agent capabilities
- **Memory Systems**: Conversation history and persistent storage
- **Agent Types**: ReAct, conversational, planning agents
- **Error Handling**: Robust production-ready patterns

---

## 🚀 Next Steps

1. **Tutorial 3**: [Agent Memory and State Management](../03-memory-and-state/)
2. **Explore Tools**: Try more LangChain tools and integrations
3. **Custom Chains**: Build specialized processing chains
4. **Deploy**: Learn about LangSmith and production deployment

---

## 📖 Additional Resources

- [LangChain Documentation](https://python.langchain.com/docs/get_started)
- [LangChain Agents Guide](https://python.langchain.com/docs/modules/agents/)
- [Tool Integration Examples](../../../resources/cheat-sheets/tool-integration.md)

---

**Excellent work!** 🎉 You've built a powerful LangChain agent with web search, memory, and safety features. You're now ready to explore more advanced agent capabilities!