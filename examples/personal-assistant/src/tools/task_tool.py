"""Task management tool for to-do items and reminders"""
from typing import List, Dict, Any

class TaskTool:
    def __init__(self):
        self._tasks: List[Dict[str, Any]] = []

    def add_task(self, title: str, priority: str = "medium", due_date: str = None) -> Dict[str, Any]:
        """Add a new task to the list"""
        task = {
            "id": f"task_{len(self._tasks) + 1}",
            "title": title,
            "priority": priority,
            "due_date": due_date,
            "completed": False
        }
        self._tasks.append(task)
        return {"status": "success", "message": f"Task '{title}' created", "task": task}

    def list_tasks(self, include_completed: bool = False) -> List[Dict[str, Any]]:
        """List current tasks"""
        if include_completed:
            return list(self._tasks)
        return [t for t in self._tasks if not t["completed"]]
