# Agent Architecture Patterns Cheat Sheet

Quick reference for common agent design patterns and architectures.

## 🏗️ Core Agent Patterns

### 1. ReAct Pattern (Reasoning + Acting)
**When to use**: General-purpose agents that need to think and act iteratively

```python
# Pseudo-code pattern
def react_agent(query):
    thought = reason_about(query)
    action = decide_action(thought)
    observation = execute_action(action)
    
    if task_complete(observation):
        return format_answer(observation)
    else:
        return react_agent(f"{query}\nThought: {thought}\nAction: {action}\nObservation: {observation}")
```

**Key Components**:
- Reasoning engine (LLM)
- Action executor (tools/functions)
- Observation processor
- Termination condition

**Best For**: Research tasks, web browsing, data analysis

---

### 2. Chain-of-Thought (CoT) Pattern
**When to use**: Complex reasoning tasks requiring step-by-step thinking

```python
def cot_agent(complex_query):
    steps = break_down_problem(complex_query)
    solutions = []
    
    for step in steps:
        solution = solve_step(step, previous_solutions=solutions)
        solutions.append(solution)
    
    return combine_solutions(solutions)
```

**Key Components**:
- Problem decomposition
- Step-by-step reasoning
- Solution aggregation

**Best For**: Math problems, logical reasoning, planning tasks

---

### 3. Multi-Agent Collaboration Pattern
**When to use**: Tasks requiring diverse expertise or parallel processing

```python
class MultiAgentSystem:
    def __init__(self):
        self.agents = {
            'researcher': ResearchAgent(),
            'writer': WritingAgent(),
            'reviewer': ReviewAgent()
        }
    
    def collaborate(self, task):
        research = self.agents['researcher'].process(task)
        draft = self.agents['writer'].process(research)
        final = self.agents['reviewer'].process(draft)
        return final
```

**Key Components**:
- Specialized agents
- Communication protocol
- Task coordination
- Result aggregation

**Best For**: Content creation, software development, analysis tasks

---

### 4. Hierarchical Agent Pattern
**When to use**: Complex tasks with clear management structure

```python
class HierarchicalAgent:
    def __init__(self):
        self.manager = ManagerAgent()
        self.workers = [WorkerAgent() for _ in range(3)]
    
    def execute(self, complex_task):
        subtasks = self.manager.plan(complex_task)
        results = []
        
        for subtask in subtasks:
            worker = self.manager.assign_worker(subtask, self.workers)
            result = worker.execute(subtask)
            results.append(result)
        
        return self.manager.aggregate(results)
```

**Key Components**:
- Manager agent (planning & coordination)
- Worker agents (execution)
- Task delegation system
- Result aggregation

**Best For**: Project management, large-scale analysis, complex workflows

---

### 5. Tool-Using Agent Pattern
**When to use**: Agents that need to interact with external systems

```python
class ToolAgent:
    def __init__(self):
        self.tools = {
            'search': WebSearchTool(),
            'calculator': CalculatorTool(),
            'database': DatabaseTool()
        }
    
    def solve(self, query):
        plan = self.create_plan(query)
        
        for step in plan:
            tool_name = self.select_tool(step)
            tool = self.tools[tool_name]
            result = tool.execute(step)
            self.update_context(result)
        
        return self.synthesize_answer()
```

**Key Components**:
- Tool registry
- Tool selection logic
- Context management
- Result synthesis

**Best For**: Data gathering, calculations, API interactions

---

### 6. Memory-Augmented Pattern
**When to use**: Long conversations or tasks requiring historical context

```python
class MemoryAgent:
    def __init__(self):
        self.short_term_memory = []
        self.long_term_memory = VectorStore()
        self.working_memory = {}
    
    def process(self, input_data):
        # Retrieve relevant memories
        relevant_context = self.long_term_memory.search(input_data)
        
        # Update working memory
        self.working_memory.update(relevant_context)
        
        # Process with context
        response = self.llm.generate(
            input_data, 
            context=self.working_memory
        )
        
        # Store in memory
        self.store_interaction(input_data, response)
        
        return response
```

**Key Components**:
- Short-term memory (conversation)
- Long-term memory (knowledge base)
- Working memory (current context)
- Memory retrieval system

**Best For**: Personal assistants, customer service, tutoring systems

---

## 🎭 Agent Personality Patterns

### 1. Role-Based Agent
```python
class RoleBasedAgent:
    def __init__(self, role_config):
        self.role = role_config['role']
        self.expertise = role_config['expertise']
        self.personality = role_config['personality']
        self.constraints = role_config['constraints']
    
    def respond(self, query):
        context = f"""
        You are a {self.role} with expertise in {self.expertise}.
        Your personality is {self.personality}.
        Constraints: {self.constraints}
        
        Query: {query}
        """
        return self.llm.generate(context)
```

### 2. Adaptive Persona Agent
```python
class AdaptiveAgent:
    def __init__(self):
        self.user_profiles = {}
        self.interaction_history = []
    
    def adapt_persona(self, user_id):
        profile = self.user_profiles.get(user_id, {})
        return {
            'communication_style': profile.get('preferred_style', 'professional'),
            'expertise_level': profile.get('expertise', 'beginner'),
            'interests': profile.get('interests', [])
        }
```

---

## 🔄 Communication Patterns

### 1. Request-Response Pattern
Simple synchronous communication
```python
def request_response(agent, query):
    return agent.process(query)
```

### 2. Publish-Subscribe Pattern
Asynchronous event-driven communication
```python
class EventBus:
    def __init__(self):
        self.subscribers = {}
    
    def publish(self, event_type, data):
        for agent in self.subscribers.get(event_type, []):
            agent.handle_event(data)
    
    def subscribe(self, agent, event_type):
        self.subscribers.setdefault(event_type, []).append(agent)
```

### 3. Contract Net Pattern
Competitive task allocation
```python
def contract_net(task, agents):
    # Call for proposals
    proposals = [agent.bid(task) for agent in agents]
    
    # Select best proposal
    winner = max(proposals, key=lambda p: p.score)
    
    # Award contract
    return winner.agent.execute(task)
```

---

## 🛡️ Safety & Control Patterns

### 1. Constitutional AI Pattern
```python
class ConstitutionalAgent:
    def __init__(self, constitution):
        self.constitution = constitution
        self.base_agent = BaseAgent()
    
    def process(self, query):
        response = self.base_agent.process(query)
        
        # Check against constitution
        if self.violates_constitution(response):
            response = self.revise_response(response, query)
        
        return response
```

### 2. Human-in-the-Loop Pattern
```python
class HITLAgent:
    def __init__(self, approval_threshold=0.8):
        self.threshold = approval_threshold
    
    def process(self, query):
        response = self.generate_response(query)
        confidence = self.calculate_confidence(response)
        
        if confidence < self.threshold:
            response = self.request_human_approval(response)
        
        return response
```

### 3. Sandboxed Execution Pattern
```python
class SandboxedAgent:
    def __init__(self):
        self.sandbox = ExecutionSandbox()
    
    def execute_action(self, action):
        # Run in isolated environment
        with self.sandbox:
            result = action.execute()
            
        # Validate result before returning
        if self.is_safe(result):
            return result
        else:
            raise SecurityException("Unsafe action detected")
```

---

## 📊 Performance Patterns

### 1. Caching Pattern
```python
class CachedAgent:
    def __init__(self):
        self.cache = {}
    
    def process(self, query):
        cache_key = self.generate_key(query)
        
        if cache_key in self.cache:
            return self.cache[cache_key]
        
        result = self.expensive_operation(query)
        self.cache[cache_key] = result
        return result
```

### 2. Streaming Pattern
```python
class StreamingAgent:
    def process_stream(self, query):
        for chunk in self.generate_chunks(query):
            yield self.process_chunk(chunk)
```

### 3. Batch Processing Pattern
```python
class BatchAgent:
    def __init__(self, batch_size=10):
        self.batch_size = batch_size
        self.queue = []
    
    def add_task(self, task):
        self.queue.append(task)
        
        if len(self.queue) >= self.batch_size:
            return self.process_batch()
    
    def process_batch(self):
        batch = self.queue[:self.batch_size]
        self.queue = self.queue[self.batch_size:]
        return [self.process_task(task) for task in batch]
```

---

## 🎯 Pattern Selection Guide

### Simple Tasks
- **Single Query**: ReAct Pattern
- **Complex Reasoning**: Chain-of-Thought Pattern
- **Tool Usage**: Tool-Using Agent Pattern

### Multi-Agent Scenarios
- **Collaboration**: Multi-Agent Collaboration Pattern
- **Management**: Hierarchical Agent Pattern
- **Competition**: Contract Net Pattern

### Long-term Interactions
- **Conversations**: Memory-Augmented Pattern
- **Personalization**: Adaptive Persona Pattern
- **Safety**: Constitutional AI Pattern

### Performance Requirements
- **Speed**: Caching Pattern
- **Scalability**: Batch Processing Pattern
- **Real-time**: Streaming Pattern

---

## 💡 Best Practices

1. **Start Simple**: Begin with ReAct or single-agent patterns
2. **Add Complexity Gradually**: Introduce multi-agent patterns as needed
3. **Consider Safety**: Always implement appropriate safety patterns
4. **Monitor Performance**: Use performance patterns for production systems
5. **Test Thoroughly**: Each pattern introduces unique failure modes
6. **Document Clearly**: Pattern selection affects maintenance and debugging

---

## 🔗 Related Resources

- [Framework Comparison](framework-comparison.md)
- [Prompt Engineering Guide](prompt-engineering.md)
- [Tool Integration Guide](tool-integration.md)
- [Multi-Agent Communication Protocols](communication-protocols.md)