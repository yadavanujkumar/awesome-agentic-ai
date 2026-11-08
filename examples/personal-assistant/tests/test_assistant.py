import pytest
import sys
from pathlib import Path

# Add project root to sys.path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.personal_assistant import PersonalAssistant

def test_calendar_scheduling():
    assistant = PersonalAssistant()
    res = assistant.process_request("Schedule team sync tomorrow at 10 AM")
    assert res["action"] == "calendar_schedule"
    assert len(assistant.calendar.list_events()) == 1

def test_task_creation():
    assistant = PersonalAssistant()
    res = assistant.process_request("Remind me to buy groceries")
    assert res["action"] == "task_create"
    assert len(assistant.tasks.list_tasks()) == 1

def test_memory_tracking():
    assistant = PersonalAssistant()
    assistant.process_request("What is the weather today?")
    messages = assistant.memory.get_messages()
    assert len(messages) == 2  # 1 user + 1 assistant
    assert messages[0]["role"] == "user"
    assert messages[1]["role"] == "assistant"
