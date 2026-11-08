"""Conversation Memory Manager"""
from typing import List, Dict, Any
from datetime import datetime, timezone

class ConversationMemory:
    """Manages short-term conversation context and history"""
    
    def __init__(self, max_history: int = 20):
        self.max_history = max_history
        self._history: List[Dict[str, Any]] = []

    def add_message(self, role: str, content: str, metadata: Dict[str, Any] = None):
        entry = {
            "role": role,
            "content": content,
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "metadata": metadata or {}
        }
        self._history.append(entry)
        if len(self._history) > self.max_history:
            self._history.pop(0)

    def get_messages(self) -> List[Dict[str, Any]]:
        return list(self._history)

    def clear(self):
        self._history.clear()
