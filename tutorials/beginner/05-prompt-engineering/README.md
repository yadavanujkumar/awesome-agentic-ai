# Tutorial 5: Prompt Engineering for Agents

**Duration**: 2-3 hours  
**Prerequisites**: [Tutorial 4: Tool Integration and Function Calling](../04-tool-integration/)  
**Goal**: Master the art of prompt engineering to make your agents more effective

## 🎯 Learning Objectives

After completing this tutorial, you will:
- Apply effective prompting strategies for agents
- Implement chain-of-thought reasoning
- Use few-shot examples and templates
- Understand system prompts vs. user prompts
- Test and iterate on prompt effectiveness

---

## 🎨 Prompt Engineering Fundamentals

### System Prompts
Define the agent's role, personality, and capabilities:

```python
SYSTEM_PROMPT = """You are a helpful research assistant AI. Your role is to:
1. Help users find reliable information on any topic
2. Provide accurate, well-sourced answers
3. Break down complex topics into understandable parts
4. Always cite your sources when possible

You have access to web search and Wikipedia tools. Use them to verify information and provide current data.

Personality: Professional but friendly, thorough but concise.
"""
```

### User Prompts
Structure user inputs for better understanding:

```python
def format_user_prompt(question, context=""):
    return f"""
Question: {question}

{f"Additional context: {context}" if context else ""}

Please provide a comprehensive answer using your available tools.
"""
```

---

## 🧠 Chain-of-Thought Reasoning

### Basic CoT Implementation
```python
COT_PROMPT = """Think through this problem step by step:

1. First, understand what is being asked
2. Identify what information you need
3. Use appropriate tools to gather information
4. Analyze the information
5. Provide a clear, well-reasoned answer

Question: {question}

Let me work through this systematically:
"""
```

### Advanced CoT with Self-Verification
```python
SELF_CHECK_PROMPT = """After providing your answer, please verify it by:
1. Double-checking key facts
2. Ensuring logical consistency
3. Confirming you've addressed all parts of the question
4. Rating your confidence level (1-10)

If you find any issues, correct them before finalizing your response.
"""
```

---

## 📝 Few-Shot Examples

### Pattern Recognition
```python
FEW_SHOT_EXAMPLES = """
Here are examples of how to handle different types of questions:

Example 1:
User: "What's the weather like?"
Assistant: I'll check the weather for you. What location would you like me to check?

Example 2:
User: "Research renewable energy trends"
Assistant: I'll research current renewable energy trends using multiple sources. Let me search for the latest information and provide you with a comprehensive overview.

Example 3:
User: "Calculate 15% tip on $67.89"
Assistant: I'll calculate that for you. 15% of $67.89 = $10.18. So the total would be $78.07.

Now, please respond to the user's question following these patterns:
"""
```

---

## 🔧 Prompt Templates

### Dynamic Template System
```python
from langchain.prompts import PromptTemplate

# Research-focused template
research_template = PromptTemplate(
    input_variables=["topic", "depth", "sources"],
    template="""
Research Task: {topic}
Depth Level: {depth} (basic/intermediate/advanced)
Required Sources: {sources}

Please conduct thorough research on this topic, using the following approach:
1. Start with a web search for current information
2. Cross-reference with Wikipedia for background
3. Look for multiple perspectives and recent developments
4. Organize findings into a clear, structured response

Focus on accuracy and provide source citations.
"""
)

# Problem-solving template
problem_template = PromptTemplate(
    input_variables=["problem", "constraints"],
    template="""
Problem: {problem}
Constraints: {constraints}

Approach this systematically:
1. Understand the problem completely
2. Identify what tools/information you need
3. Break down into manageable steps
4. Execute step by step
5. Verify your solution

Think carefully and show your reasoning.
"""
)
```

---

## 🎭 Personality and Tone

### Adaptive Personality System
```python
PERSONALITIES = {
    "professional": {
        "tone": "formal and business-like",
        "style": "structured and detailed",
        "greeting": "Good day. How may I assist you with your inquiry?"
    },
    "friendly": {
        "tone": "warm and conversational",
        "style": "approachable and encouraging",
        "greeting": "Hi there! I'm excited to help you today. What would you like to explore?"
    },
    "teacher": {
        "tone": "patient and educational",
        "style": "explanatory with examples",
        "greeting": "Hello, student! I'm here to help you learn. What topic interests you?"
    }
}

def get_personality_prompt(personality_type):
    p = PERSONALITIES.get(personality_type, PERSONALITIES["professional"])
    return f"""
Adopt a {p['tone']} tone with a {p['style']} communication style.
Greeting: "{p['greeting']}"

Maintain this personality consistently throughout our conversation.
"""
```

---

## 🧪 Testing and Optimization

### Prompt A/B Testing
```python
def test_prompt_effectiveness(prompts, test_cases):
    """Test different prompts against the same inputs"""
    results = {}
    
    for prompt_name, prompt_template in prompts.items():
        results[prompt_name] = []
        
        for test_case in test_cases:
            # Run agent with this prompt
            agent = create_agent_with_prompt(prompt_template)
            response = agent.run(test_case["input"])
            
            # Evaluate response
            score = evaluate_response(response, test_case["expected"])
            results[prompt_name].append(score)
    
    return results

def evaluate_response(response, expected_criteria):
    """Score response based on criteria"""
    score = 0
    
    # Check for accuracy, completeness, clarity, etc.
    if "accurate information" in expected_criteria:
        score += check_accuracy(response)
    
    if "uses tools appropriately" in expected_criteria:
        score += check_tool_usage(response)
    
    if "clear explanation" in expected_criteria:
        score += check_clarity(response)
    
    return score / len(expected_criteria)
```

---

## 📊 Prompt Performance Metrics

### Key Metrics to Track
1. **Accuracy**: Factual correctness of responses
2. **Completeness**: Addresses all parts of the question
3. **Efficiency**: Appropriate tool usage
4. **Clarity**: Easy to understand
5. **Consistency**: Maintains character/role

### Monitoring Framework
```python
class PromptMonitor:
    def __init__(self):
        self.metrics = {
            "total_queries": 0,
            "successful_responses": 0,
            "tool_usage_rate": 0,
            "average_response_time": 0
        }
    
    def log_interaction(self, query, response, success, tools_used, response_time):
        self.metrics["total_queries"] += 1
        if success:
            self.metrics["successful_responses"] += 1
        
        # Update other metrics...
    
    def get_performance_report(self):
        success_rate = self.metrics["successful_responses"] / self.metrics["total_queries"]
        return f"Success rate: {success_rate:.2%}"
```

---

## 📚 Advanced Techniques

### Context-Aware Prompting
```python
def build_context_aware_prompt(user_input, conversation_history, user_profile):
    context = f"""
Previous conversation context: {conversation_history[-3:]}
User profile: {user_profile}
Current query: {user_input}

Consider the conversation history and user preferences when responding.
Maintain continuity and personalization.
"""
    return context
```

### Multi-Modal Prompting
```python
def create_multimodal_prompt(text, image_description=None, document_context=None):
    prompt = f"Text input: {text}\n"
    
    if image_description:
        prompt += f"Image context: {image_description}\n"
    
    if document_context:
        prompt += f"Document context: {document_context}\n"
    
    prompt += "Please consider all provided context in your response."
    return prompt
```

---

## 🎯 Exercises

1. **Prompt Optimization**: Take a basic prompt and improve it through iteration
2. **Personality Development**: Create a unique agent personality with consistent traits
3. **Domain Specialization**: Build prompts for specific fields (medical, legal, technical)
4. **Multi-turn Conversation**: Design prompts that maintain context across exchanges
5. **Error Recovery**: Create prompts that help agents recover from misunderstandings

---

## 📖 Best Practices

1. **Be Specific**: Clear instructions yield better results
2. **Provide Examples**: Show the agent what good responses look like
3. **Set Boundaries**: Define what the agent should and shouldn't do
4. **Test Thoroughly**: Use diverse test cases and edge cases
5. **Iterate Continuously**: Prompt engineering is an ongoing process

---

## 🚀 Next Steps

Continue to [Tutorial 6: Deploying Your First Agent](../06-deployment/)

---

**Additional Resources:**
- [Prompt Engineering Guide](../../../resources/cheat-sheets/prompt-engineering.md)
- [Agent Architecture Patterns](../../../resources/cheat-sheets/agent-patterns.md)

---

*This tutorial is part of the [Beginner Tutorial Series](../) for Agentic AI development.*