"""Email triage and drafting tool"""
from typing import List, Dict, Any

class EmailTool:
    def __init__(self):
        self._outbox: List[Dict[str, Any]] = []

    def draft_email(self, recipient: str, subject: str, body: str) -> Dict[str, Any]:
        """Draft an email for review"""
        draft = {
            "id": f"draft_{len(self._outbox) + 1}",
            "recipient": recipient,
            "subject": subject,
            "body": body,
            "status": "draft"
        }
        self._outbox.append(draft)
        return {"status": "success", "message": f"Draft created for {recipient}", "draft": draft}

    def summarize_inbox(self) -> List[Dict[str, Any]]:
        """Simulate fetching and triaging incoming emails"""
        return [
            {"id": "msg_1", "from": "alex@company.com", "subject": "Project sync", "priority": "high"},
            {"id": "msg_2", "from": "newsletter@tech.com", "subject": "Weekly AI Digest", "priority": "low"}
        ]
