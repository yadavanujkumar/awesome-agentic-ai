# Multi-Agent Communication Protocols

Guide to communication patterns and protocols for multi-agent AI systems.

## 🗣️ Communication Fundamentals

### Core Principles
1. **Clear Intent**: Messages should clearly state their purpose
2. **Structured Format**: Consistent message structure aids processing
3. **Context Preservation**: Maintain conversation context across interactions
4. **Error Handling**: Graceful handling of communication failures
5. **Scalability**: Protocols should work with varying numbers of agents

### Message Types
- **Query**: Request for information or action
- **Response**: Answer to a query
- **Notification**: One-way information sharing
- **Command**: Direct instruction to perform an action
- **Acknowledgment**: Confirmation of message receipt
- **Error**: Communication or processing failure notification

---

## 📋 Standard Message Formats

### 1. Basic Message Structure

```json
{
  "message_id": "unique_identifier",
  "timestamp": "2024-01-15T10:30:00Z",
  "sender": "agent_name",
  "recipient": "target_agent_or_broadcast",
  "message_type": "query|response|notification|command|ack|error",
  "content": {
    "subject": "brief_description",
    "body": "main_content",
    "metadata": {
      "priority": "high|medium|low",
      "requires_response": true,
      "expires_at": "2024-01-15T11:00:00Z"
    }
  },
  "context": {
    "conversation_id": "conversation_identifier",
    "thread_id": "thread_identifier",
    "previous_message_id": "reference_to_previous_message"
  }
}
```

### 2. Task-Oriented Message Format

```json
{
  "message_id": "task_001",
  "sender": "project_manager_agent",
  "recipient": "developer_agent",
  "message_type": "command",
  "content": {
    "task": {
      "action": "implement_feature",
      "parameters": {
        "feature_name": "user_authentication",
        "requirements": ["secure", "fast", "user-friendly"],
        "deadline": "2024-01-20T17:00:00Z"
      },
      "resources": {
        "documentation": ["auth_spec.md", "security_guidelines.md"],
        "dependencies": ["user_model", "security_module"]
      }
    }
  },
  "expected_response": {
    "format": "progress_report",
    "timeline": "daily_updates"
  }
}
```

### 3. Collaboration Message Format

```json
{
  "message_id": "collab_001",
  "sender": "research_agent",
  "recipient": "writing_team",
  "message_type": "notification",
  "content": {
    "collaboration": {
      "project": "market_analysis_report",
      "phase": "data_gathering_complete",
      "deliverable": {
        "type": "research_findings",
        "location": "shared_workspace/research_data.json",
        "summary": "Found 47 relevant studies, 23 market reports, 156 data points"
      },
      "next_steps": [
        "analyze_trends",
        "identify_opportunities",
        "draft_executive_summary"
      ]
    }
  },
  "collaboration_context": {
    "workspace": "shared_workspace_id",
    "participants": ["research_agent", "analyst_agent", "writer_agent"],
    "workflow_stage": "data_analysis"
  }
}
```

---

## 🤝 Communication Patterns

### 1. Request-Response Pattern

```python
# Synchronous Request-Response
class RequestResponseAgent:
    def __init__(self, name):
        self.name = name
        self.message_queue = []
    
    def send_request(self, recipient, request_content):
        message = {
            "message_id": self.generate_id(),
            "sender": self.name,
            "recipient": recipient.name,
            "message_type": "query",
            "content": request_content,
            "timestamp": datetime.now().isoformat()
        }
        
        response = recipient.handle_message(message)
        return response
    
    def handle_message(self, message):
        if message["message_type"] == "query":
            # Process the request
            result = self.process_request(message["content"])
            
            # Send response
            response = {
                "message_id": self.generate_id(),
                "sender": self.name,
                "recipient": message["sender"],
                "message_type": "response",
                "content": result,
                "reference_id": message["message_id"]
            }
            return response
```

### 2. Publish-Subscribe Pattern

```python
class MessageBroker:
    def __init__(self):
        self.subscribers = {}
        self.message_history = []
    
    def subscribe(self, agent, topic):
        if topic not in self.subscribers:
            self.subscribers[topic] = []
        self.subscribers[topic].append(agent)
    
    def publish(self, topic, message):
        self.message_history.append({
            "topic": topic,
            "message": message,
            "timestamp": datetime.now().isoformat()
        })
        
        for agent in self.subscribers.get(topic, []):
            agent.receive_notification(message)
    
    def unsubscribe(self, agent, topic):
        if topic in self.subscribers:
            self.subscribers[topic].remove(agent)

# Usage
broker = MessageBroker()

# Agents subscribe to topics
broker.subscribe(data_agent, "data_updates")
broker.subscribe(analysis_agent, "data_updates")
broker.subscribe(dashboard_agent, "analysis_complete")

# Publish updates
broker.publish("data_updates", {
    "type": "new_data_available",
    "source": "external_api",
    "record_count": 1500
})
```

### 3. Workflow Coordination Pattern

```python
class WorkflowCoordinator:
    def __init__(self):
        self.workflow_state = {}
        self.agents = {}
        self.task_dependencies = {}
    
    def register_agent(self, agent):
        self.agents[agent.name] = agent
    
    def define_workflow(self, workflow_id, tasks):
        """
        Define a workflow with task dependencies
        tasks: [{"id": "task1", "agent": "agent1", "depends_on": []}]
        """
        self.workflow_state[workflow_id] = {
            "tasks": tasks,
            "completed": [],
            "in_progress": [],
            "pending": [t["id"] for t in tasks if not t["depends_on"]]
        }
    
    def execute_workflow(self, workflow_id):
        workflow = self.workflow_state[workflow_id]
        
        while workflow["pending"] or workflow["in_progress"]:
            # Start ready tasks
            for task_id in workflow["pending"]:
                task = next(t for t in workflow["tasks"] if t["id"] == task_id)
                agent = self.agents[task["agent"]]
                
                # Send task to agent
                message = {
                    "message_id": f"task_{task_id}",
                    "message_type": "command",
                    "content": {
                        "task_id": task_id,
                        "workflow_id": workflow_id,
                        "task_details": task
                    }
                }
                
                agent.handle_message(message)
                workflow["in_progress"].append(task_id)
                workflow["pending"].remove(task_id)
    
    def task_completed(self, workflow_id, task_id):
        workflow = self.workflow_state[workflow_id]
        workflow["completed"].append(task_id)
        workflow["in_progress"].remove(task_id)
        
        # Check for newly available tasks
        for task in workflow["tasks"]:
            if (task["id"] not in workflow["completed"] and 
                task["id"] not in workflow["in_progress"] and
                all(dep in workflow["completed"] for dep in task["depends_on"])):
                workflow["pending"].append(task["id"])
```

### 4. Negotiation Pattern

```python
class NegotiationProtocol:
    def __init__(self):
        self.negotiations = {}
    
    def start_negotiation(self, negotiation_id, participants, topic):
        self.negotiations[negotiation_id] = {
            "participants": participants,
            "topic": topic,
            "proposals": [],
            "status": "active",
            "round": 1
        }
        
        # Notify all participants
        for participant in participants:
            participant.handle_message({
                "message_type": "notification",
                "content": {
                    "negotiation_id": negotiation_id,
                    "action": "negotiation_started",
                    "topic": topic,
                    "participants": [p.name for p in participants]
                }
            })
    
    def submit_proposal(self, negotiation_id, agent, proposal):
        negotiation = self.negotiations[negotiation_id]
        
        proposal_entry = {
            "agent": agent.name,
            "proposal": proposal,
            "round": negotiation["round"],
            "timestamp": datetime.now().isoformat()
        }
        
        negotiation["proposals"].append(proposal_entry)
        
        # Notify other participants
        for participant in negotiation["participants"]:
            if participant != agent:
                participant.handle_message({
                    "message_type": "notification",
                    "content": {
                        "negotiation_id": negotiation_id,
                        "action": "new_proposal",
                        "proposal": proposal_entry
                    }
                })
    
    def evaluate_consensus(self, negotiation_id):
        negotiation = self.negotiations[negotiation_id]
        current_round_proposals = [
            p for p in negotiation["proposals"] 
            if p["round"] == negotiation["round"]
        ]
        
        if len(current_round_proposals) == len(negotiation["participants"]):
            # All participants have submitted proposals
            consensus = self.check_consensus(current_round_proposals)
            
            if consensus:
                self.finalize_negotiation(negotiation_id, consensus)
            else:
                self.start_next_round(negotiation_id)
```

---

## 🏗️ Framework-Specific Implementations

### AutoGen Communication

```python
import autogen

class MultiAgentDiscussion:
    def __init__(self):
        self.participants = []
        self.conversation_history = []
    
    def setup_agents(self):
        # Moderator agent
        self.moderator = autogen.AssistantAgent(
            name="moderator",
            system_message="""You are a discussion moderator. Your role is to:
            1. Guide the conversation toward productive outcomes
            2. Ensure all participants contribute
            3. Summarize key points and decisions
            4. Manage turn-taking and time limits"""
        )
        
        # Specialist agents
        self.researcher = autogen.AssistantAgent(
            name="researcher",
            system_message="""You are a research specialist. Focus on:
            1. Providing evidence-based insights
            2. Fact-checking claims made by others
            3. Suggesting additional research directions"""
        )
        
        self.analyst = autogen.AssistantAgent(
            name="analyst",
            system_message="""You are a data analyst. Your responsibilities:
            1. Analyze quantitative data and trends
            2. Provide statistical insights
            3. Create data visualizations when needed"""
        )
        
        self.participants = [self.moderator, self.researcher, self.analyst]
    
    def initiate_discussion(self, topic):
        user_proxy = autogen.UserProxyAgent(
            name="user",
            human_input_mode="NEVER",
            max_consecutive_auto_reply=1
        )
        
        # Create group chat
        group_chat = autogen.GroupChat(
            agents=self.participants + [user_proxy],
            messages=[],
            max_round=10
        )
        
        manager = autogen.GroupChatManager(groupchat=group_chat)
        
        # Start discussion
        user_proxy.initiate_chat(
            manager,
            message=f"Let's discuss: {topic}"
        )
```

### CrewAI Team Communication

```python
from crewai import Agent, Task, Crew

class CrewAIWorkflow:
    def __init__(self):
        self.setup_crew()
    
    def setup_crew(self):
        # Define agents with specific communication roles
        self.project_manager = Agent(
            role='Project Manager',
            goal='Coordinate team activities and ensure project success',
            backstory="""You are an experienced project manager who excels at 
            coordinating teams, managing timelines, and ensuring deliverables 
            meet quality standards.""",
            verbose=True
        )
        
        self.researcher = Agent(
            role='Senior Researcher',
            goal='Conduct thorough research and provide accurate information',
            backstory="""You are a detail-oriented researcher with expertise 
            in gathering, analyzing, and synthesizing information from multiple sources.""",
            verbose=True
        )
        
        self.writer = Agent(
            role='Content Writer',
            goal='Create compelling and informative content',
            backstory="""You are a skilled writer who can transform complex 
            information into clear, engaging content for various audiences.""",
            verbose=True
        )
    
    def create_collaborative_task(self, topic):
        # Research phase
        research_task = Task(
            description=f"""Research the topic: {topic}
            
            Communication protocol:
            1. Share findings with the team as you discover them
            2. Highlight key insights that will impact content creation
            3. Provide source citations and credibility assessments
            4. Flag any conflicting information for team discussion
            
            Deliverable: Comprehensive research report with sources""",
            agent=self.researcher
        )
        
        # Writing phase  
        writing_task = Task(
            description=f"""Based on the research findings, create content about: {topic}
            
            Communication requirements:
            1. Review and acknowledge the research findings
            2. Ask clarifying questions if research gaps exist
            3. Share draft sections for feedback before finalizing
            4. Incorporate team feedback into final version
            
            Deliverable: Well-written article incorporating all research""",
            agent=self.writer
        )
        
        # Management coordination
        coordination_task = Task(
            description=f"""Manage the collaborative process for: {topic}
            
            Coordination responsibilities:
            1. Monitor progress of research and writing tasks
            2. Facilitate communication between team members
            3. Ensure quality standards are met
            4. Resolve any conflicts or resource constraints
            5. Provide final project summary and lessons learned
            
            Deliverable: Project completion report with team performance assessment""",
            agent=self.project_manager
        )
        
        # Create crew with communication protocols
        crew = Crew(
            agents=[self.researcher, self.writer, self.project_manager],
            tasks=[research_task, writing_task, coordination_task],
            verbose=2
        )
        
        return crew.kickoff()
```

### LangChain Multi-Agent Communication

```python
from langchain.agents import AgentExecutor
from langchain.memory import ConversationBufferMemory
from langchain.schema import BaseMessage, HumanMessage, AIMessage

class LangChainCommunicationHub:
    def __init__(self):
        self.agents = {}
        self.message_bus = []
        self.shared_memory = ConversationBufferMemory()
    
    def register_agent(self, name, agent):
        self.agents[name] = {
            "agent": agent,
            "inbox": [],
            "outbox": []
        }
    
    def send_message(self, sender, recipient, message_content):
        message = {
            "id": len(self.message_bus),
            "sender": sender,
            "recipient": recipient,
            "content": message_content,
            "timestamp": datetime.now().isoformat(),
            "status": "sent"
        }
        
        self.message_bus.append(message)
        
        if recipient in self.agents:
            self.agents[recipient]["inbox"].append(message)
        
        # Update shared memory
        self.shared_memory.chat_memory.add_message(
            HumanMessage(content=f"[{sender} to {recipient}]: {message_content}")
        )
    
    def process_agent_messages(self, agent_name):
        agent_data = self.agents[agent_name]
        inbox = agent_data["inbox"]
        
        for message in inbox:
            if message["status"] == "sent":
                # Process message with agent
                response = self.process_message_with_agent(
                    agent_data["agent"], 
                    message
                )
                
                # Send response if needed
                if response:
                    self.send_message(
                        agent_name, 
                        message["sender"], 
                        response
                    )
                
                message["status"] = "processed"
    
    def broadcast_message(self, sender, message_content):
        for agent_name in self.agents:
            if agent_name != sender:
                self.send_message(sender, agent_name, message_content)
    
    def get_conversation_history(self):
        return self.shared_memory.chat_memory.messages
```

---

## 🔒 Security & Privacy in Agent Communication

### 1. Message Encryption

```python
from cryptography.fernet import Fernet
import json

class SecureCommunication:
    def __init__(self):
        self.keys = {}  # Agent ID -> encryption key
        self.master_key = Fernet.generate_key()
        self.cipher = Fernet(self.master_key)
    
    def register_agent(self, agent_id):
        """Register agent and generate unique encryption key"""
        agent_key = Fernet.generate_key()
        self.keys[agent_id] = agent_key
        return agent_key
    
    def encrypt_message(self, sender_id, message):
        """Encrypt message using sender's key"""
        if sender_id not in self.keys:
            raise ValueError(f"Agent {sender_id} not registered")
        
        cipher = Fernet(self.keys[sender_id])
        message_bytes = json.dumps(message).encode()
        encrypted = cipher.encrypt(message_bytes)
        
        return {
            "sender": sender_id,
            "encrypted_content": encrypted.decode(),
            "timestamp": datetime.now().isoformat()
        }
    
    def decrypt_message(self, sender_id, encrypted_message):
        """Decrypt message using sender's key"""
        if sender_id not in self.keys:
            raise ValueError(f"Agent {sender_id} not registered")
        
        cipher = Fernet(self.keys[sender_id])
        encrypted_bytes = encrypted_message["encrypted_content"].encode()
        decrypted_bytes = cipher.decrypt(encrypted_bytes)
        
        return json.loads(decrypted_bytes.decode())
```

### 2. Access Control

```python
class AccessControlManager:
    def __init__(self):
        self.permissions = {}  # agent_id -> {allowed_recipients, allowed_topics}
        self.message_filters = {}
    
    def set_permissions(self, agent_id, allowed_recipients=None, allowed_topics=None):
        """Set communication permissions for an agent"""
        self.permissions[agent_id] = {
            "allowed_recipients": allowed_recipients or [],
            "allowed_topics": allowed_topics or [],
            "can_broadcast": False
        }
    
    def check_permission(self, sender_id, recipient_id, topic=None):
        """Check if sender can communicate with recipient on topic"""
        if sender_id not in self.permissions:
            return False
        
        perms = self.permissions[sender_id]
        
        # Check recipient permission
        if perms["allowed_recipients"] and recipient_id not in perms["allowed_recipients"]:
            return False
        
        # Check topic permission
        if topic and perms["allowed_topics"] and topic not in perms["allowed_topics"]:
            return False
        
        return True
    
    def filter_message(self, message, recipient_id):
        """Apply content filters based on recipient"""
        if recipient_id in self.message_filters:
            filter_func = self.message_filters[recipient_id]
            return filter_func(message)
        
        return message
```

---

## 📊 Communication Monitoring & Analytics

### Message Flow Analytics

```python
class CommunicationAnalytics:
    def __init__(self):
        self.message_log = []
        self.agent_stats = {}
        self.conversation_threads = {}
    
    def log_message(self, message):
        """Log message for analytics"""
        self.message_log.append({
            **message,
            "logged_at": datetime.now().isoformat()
        })
        
        # Update agent statistics
        sender = message["sender"]
        if sender not in self.agent_stats:
            self.agent_stats[sender] = {
                "messages_sent": 0,
                "messages_received": 0,
                "topics": set(),
                "communication_partners": set()
            }
        
        self.agent_stats[sender]["messages_sent"] += 1
        
        if "topic" in message.get("content", {}):
            self.agent_stats[sender]["topics"].add(message["content"]["topic"])
        
        recipient = message.get("recipient")
        if recipient:
            self.agent_stats[sender]["communication_partners"].add(recipient)
            
            # Update recipient stats
            if recipient not in self.agent_stats:
                self.agent_stats[recipient] = {
                    "messages_sent": 0,
                    "messages_received": 0,
                    "topics": set(),
                    "communication_partners": set()
                }
            self.agent_stats[recipient]["messages_received"] += 1
    
    def get_communication_patterns(self):
        """Analyze communication patterns"""
        patterns = {
            "most_active_agents": sorted(
                self.agent_stats.items(),
                key=lambda x: x[1]["messages_sent"],
                reverse=True
            )[:5],
            "communication_network": self.build_network_graph(),
            "popular_topics": self.analyze_topics(),
            "response_times": self.calculate_response_times()
        }
        
        return patterns
    
    def build_network_graph(self):
        """Build communication network representation"""
        network = {}
        
        for message in self.message_log:
            sender = message["sender"]
            recipient = message.get("recipient")
            
            if recipient and recipient != "broadcast":
                if sender not in network:
                    network[sender] = {}
                
                if recipient not in network[sender]:
                    network[sender][recipient] = 0
                
                network[sender][recipient] += 1
        
        return network
    
    def analyze_topics(self):
        """Analyze most discussed topics"""
        topic_counts = {}
        
        for message in self.message_log:
            content = message.get("content", {})
            if "topic" in content:
                topic = content["topic"]
                topic_counts[topic] = topic_counts.get(topic, 0) + 1
        
        return sorted(topic_counts.items(), key=lambda x: x[1], reverse=True)
```

---

## 🛠️ Protocol Implementation Tools

### Message Validation

```python
from jsonschema import validate, ValidationError

class MessageValidator:
    def __init__(self):
        self.schemas = self.load_message_schemas()
    
    def load_message_schemas(self):
        """Define JSON schemas for different message types"""
        return {
            "query": {
                "type": "object",
                "required": ["message_id", "sender", "recipient", "content"],
                "properties": {
                    "message_id": {"type": "string"},
                    "sender": {"type": "string"},
                    "recipient": {"type": "string"},
                    "message_type": {"enum": ["query"]},
                    "content": {
                        "type": "object",
                        "required": ["question"],
                        "properties": {
                            "question": {"type": "string"},
                            "context": {"type": "string"}
                        }
                    }
                }
            },
            "command": {
                "type": "object",
                "required": ["message_id", "sender", "recipient", "content"],
                "properties": {
                    "content": {
                        "type": "object",
                        "required": ["action"],
                        "properties": {
                            "action": {"type": "string"},
                            "parameters": {"type": "object"}
                        }
                    }
                }
            }
        }
    
    def validate_message(self, message):
        """Validate message against appropriate schema"""
        message_type = message.get("message_type", "query")
        
        if message_type not in self.schemas:
            raise ValidationError(f"Unknown message type: {message_type}")
        
        try:
            validate(instance=message, schema=self.schemas[message_type])
            return True
        except ValidationError as e:
            raise ValidationError(f"Message validation failed: {e.message}")
```

---

## 📚 Best Practices Summary

### Do's ✅
- **Use consistent message formats** across all agents
- **Implement proper error handling** for communication failures
- **Log all messages** for debugging and analytics
- **Validate message structure** before processing
- **Set timeouts** for message responses
- **Use structured data** rather than free-form text when possible

### Don'ts ❌
- **Don't assume message delivery** - implement acknowledgments
- **Don't hardcode agent names** - use dynamic discovery
- **Don't ignore security** - encrypt sensitive communications
- **Don't create circular dependencies** in agent conversations
- **Don't flood the network** - implement rate limiting

### Performance Considerations
- Use **asynchronous communication** when possible
- Implement **message queuing** for high-volume scenarios
- **Batch related messages** to reduce overhead
- **Cache frequently accessed information** locally
- **Monitor network usage** and optimize protocols

---

This guide provides a comprehensive foundation for implementing robust communication protocols in multi-agent AI systems. The patterns and examples can be adapted to specific frameworks and use cases while maintaining consistency and reliability.