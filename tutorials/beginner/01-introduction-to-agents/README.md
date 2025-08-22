# Tutorial 1: Introduction to AI Agents

**Duration**: 1-2 hours  
**Prerequisites**: Basic Python knowledge  
**Goal**: Understand AI agent fundamentals and build your first simple agent

## 🎯 Learning Objectives

After completing this tutorial, you will:
- Understand what makes AI systems "agentic"
- Know the key components of AI agents
- Build a basic conversational agent
- Implement simple decision-making logic
- Test and debug your agent

---

## 📚 What Are AI Agents?

AI agents are systems that can:
- **Perceive** their environment
- **Reason** about goals and actions
- **Act** autonomously to achieve objectives
- **Learn** from feedback and experience

Unlike traditional software that follows predefined rules, agents make decisions based on their understanding of the situation and their goals.

### Key Components

1. **LLM (Large Language Model)**: The "brain" that processes information and generates responses
2. **Memory**: Stores conversation history and learned information
3. **Tools**: External capabilities the agent can use (APIs, databases, etc.)
4. **Planning**: Logic for breaking down complex tasks into steps

---

## 🛠️ Building Your First Agent

### Step 1: Environment Setup

```bash
# Create project directory
mkdir my-first-agent
cd my-first-agent

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install openai python-dotenv
```

### Step 2: Basic Agent Structure

Create `simple_agent.py`:

```python
import os
from openai import OpenAI
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class SimpleAgent:
    def __init__(self):
        self.client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
        self.system_prompt = """You are a helpful AI assistant. 
        You can answer questions and help with various tasks.
        Always be polite and informative."""
        
    def think(self, user_input):
        """Process user input and generate response"""
        try:
            response = self.client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": self.system_prompt},
                    {"role": "user", "content": user_input}
                ],
                max_tokens=150,
                temperature=0.7
            )
            return response.choices[0].message.content
        except Exception as e:
            return f"Error: {str(e)}"
    
    def run(self):
        """Main interaction loop"""
        print("🤖 Simple AI Agent initialized!")
        print("Type 'quit' to exit\n")
        
        while True:
            user_input = input("You: ").strip()
            
            if user_input.lower() in ['quit', 'exit', 'bye']:
                print("🤖 Agent: Goodbye!")
                break
                
            if not user_input:
                continue
                
            response = self.think(user_input)
            print(f"🤖 Agent: {response}\n")

if __name__ == "__main__":
    agent = SimpleAgent()
    agent.run()
```

### Step 3: Environment Variables

Create `.env` file:

```env
OPENAI_API_KEY=your_openai_api_key_here
```

---

## 🧠 Adding Decision-Making Logic

Let's enhance our agent with basic decision-making:

```python
import os
import json
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

class DecisionAgent:
    def __init__(self):
        self.client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
        self.capabilities = [
            "answer_questions",
            "provide_definitions", 
            "give_advice",
            "help_with_math",
            "tell_jokes"
        ]
        
    def analyze_intent(self, user_input):
        """Determine what the user wants to do"""
        prompt = f"""
        Analyze this user input and determine the intent: "{user_input}"
        
        Choose from these capabilities:
        {', '.join(self.capabilities)}
        
        Respond with just the capability name.
        """
        
        response = self.client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=50
        )
        
        return response.choices[0].message.content.strip()
    
    def handle_request(self, user_input, intent):
        """Handle the request based on intent"""
        if intent == "help_with_math":
            return self.solve_math(user_input)
        elif intent == "tell_jokes":
            return self.tell_joke()
        else:
            return self.general_response(user_input)
    
    def solve_math(self, question):
        """Handle math problems"""
        prompt = f"""
        Solve this math problem step by step: {question}
        Show your work clearly.
        """
        
        response = self.client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=200
        )
        
        return response.choices[0].message.content
    
    def tell_joke(self):
        """Tell a joke"""
        prompt = "Tell me a clean, family-friendly joke."
        
        response = self.client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=100
        )
        
        return response.choices[0].message.content
    
    def general_response(self, user_input):
        """Handle general questions"""
        response = self.client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": user_input}
            ],
            max_tokens=150
        )
        
        return response.choices[0].message.content
    
    def run(self):
        """Main interaction loop with decision-making"""
        print("🤖 Decision Agent initialized!")
        print(f"My capabilities: {', '.join(self.capabilities)}")
        print("Type 'quit' to exit\n")
        
        while True:
            user_input = input("You: ").strip()
            
            if user_input.lower() in ['quit', 'exit', 'bye']:
                print("🤖 Agent: Goodbye!")
                break
                
            if not user_input:
                continue
            
            # Analyze intent and respond accordingly
            intent = self.analyze_intent(user_input)
            print(f"🔍 Detected intent: {intent}")
            
            response = self.handle_request(user_input, intent)
            print(f"🤖 Agent: {response}\n")

if __name__ == "__main__":
    agent = DecisionAgent()
    agent.run()
```

---

## 🧪 Testing Your Agent

### Test Cases

1. **Math Problem**: "What is 25 * 4 + 10?"
2. **General Question**: "What is the capital of France?"
3. **Joke Request**: "Tell me a joke"
4. **Definition**: "What is machine learning?"

### Expected Behaviors

- Agent should identify the correct intent
- Responses should be appropriate to the request type
- Math problems should show step-by-step solutions
- Agent should handle errors gracefully

---

## 🎯 Exercises

### Exercise 1: Add New Capability
Add a "weather_info" capability that tells users it can't access real weather but suggests checking weather.com.

### Exercise 2: Improve Intent Detection
Modify the intent analysis to handle ambiguous inputs better.

### Exercise 3: Add Personality
Give your agent a unique personality (e.g., pirate, scientist, comedian).

---

## 🔍 Debugging Tips

1. **Check API Keys**: Ensure your OpenAI API key is valid and loaded
2. **Monitor Token Usage**: Keep track of API costs
3. **Handle Errors**: Add try-catch blocks for network issues
4. **Test Edge Cases**: Try empty inputs, very long inputs, special characters

---

## 📚 Key Concepts Review

- **Agents vs. Chatbots**: Agents make decisions and take actions
- **Intent Detection**: Understanding what users want to accomplish
- **Modular Design**: Separate concerns (intent analysis, response generation)
- **Error Handling**: Always plan for things to go wrong

---

## 🚀 Next Steps

1. **Tutorial 2**: [Building Your First Agent with LangChain](../02-first-agent-langchain/)
2. **Add Memory**: Store conversation history
3. **Integrate Tools**: Add external capabilities
4. **Deploy**: Make your agent accessible to others

---

## 📖 Additional Resources

- [OpenAI API Documentation](https://platform.openai.com/docs/)
- [ReAct Paper](https://arxiv.org/abs/2210.03629)
- [Agent Architecture Patterns](../../../resources/cheat-sheets/agent-patterns.md)

---

**Congratulations!** 🎉 You've built your first AI agent. You now understand the basics of agent architecture and decision-making. Ready for more advanced topics? Continue to Tutorial 2!