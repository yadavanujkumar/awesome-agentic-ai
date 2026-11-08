"""
Main Personal Assistant Agent
Orchestrates Intent Classification, Tool Execution, and Context Management.
"""

from typing import Dict, Any, Optional
from src.utils.config import AssistantConfig
from src.memory.conversation_memory import ConversationMemory
from src.tools.calendar_tool import CalendarTool
from src.tools.email_tool import EmailTool
from src.tools.task_tool import TaskTool
from src.tools.search_tool import SearchTool

class PersonalAssistant:
    def __init__(self, config: Optional[AssistantConfig] = None):
        self.config = config or AssistantConfig.from_env()
        self.memory = ConversationMemory()
        self.calendar = CalendarTool()
        self.email = EmailTool()
        self.tasks = TaskTool()
        self.search = SearchTool()

    def process_request(self, user_prompt: str) -> Dict[str, Any]:
        """Classify user intent and route to appropriate tools"""
        prompt_lower = user_prompt.lower()
        self.memory.add_message("user", user_prompt)
        
        response_data: Dict[str, Any] = {}

        # Intent detection heuristic (can be backed by LLM tool calling)
        if any(w in prompt_lower for w in ["meeting", "schedule", "calendar", "appointment"]):
            result = self.calendar.schedule_event(
                title=user_prompt,
                start_time="Tomorrow 14:00"
            )
            response_data = {
                "action": "calendar_schedule",
                "result": result,
                "response": f"I have scheduled: {result['message']}"
            }
        elif any(w in prompt_lower for w in ["email", "draft", "inbox"]):
            result = self.email.draft_email(
                recipient="team@example.com",
                subject="Follow-up",
                body=user_prompt
            )
            response_data = {
                "action": "email_draft",
                "result": result,
                "response": f"Email draft prepared for {result['draft']['recipient']}"
            }
        elif any(w in prompt_lower for w in ["task", "todo", "to-do", "remind"]):
            result = self.tasks.add_task(title=user_prompt)
            response_data = {
                "action": "task_create",
                "result": result,
                "response": f"Added task: {result['task']['title']}"
            }
        else:
            result = self.search.search(query=user_prompt)
            response_data = {
                "action": "search",
                "result": result,
                "response": f"Researched: {result['results'][0]['snippet']}"
            }

        self.memory.add_message("assistant", response_data["response"])
        return response_data
