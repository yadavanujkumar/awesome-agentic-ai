"""Calendar management tool for scheduling and conflict checking"""
from typing import List, Dict, Any, Optional
from datetime import datetime

class CalendarTool:
    def __init__(self):
        # In-memory store for events
        self._events: List[Dict[str, Any]] = []

    def schedule_event(self, title: str, start_time: str, duration_minutes: int = 30, description: str = "") -> Dict[str, Any]:
        """Schedule a new calendar event"""
        event = {
            "id": f"evt_{len(self._events) + 1}",
            "title": title,
            "start_time": start_time,
            "duration_minutes": duration_minutes,
            "description": description
        }
        self._events.append(event)
        return {"status": "success", "message": f"Scheduled '{title}' at {start_time}", "event": event}

    def list_events(self) -> List[Dict[str, Any]]:
        """List all upcoming scheduled events"""
        return list(self._events)
