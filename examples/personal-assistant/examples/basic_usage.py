"""Example usage of PersonalAssistant agent"""
import sys
from pathlib import Path

# Add src to pythonpath
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.personal_assistant import PersonalAssistant

def main():
    print("🤖 Initializing Personal Assistant...")
    assistant = PersonalAssistant()
    
    queries = [
        "Schedule a meeting with John tomorrow at 2 PM about the project review",
        "Remind me to submit the quarterly report by Friday",
        "Draft an email to the client summarizing sprint progress",
        "What are the latest best practices for agentic AI?"
    ]
    
    for query in queries:
        print(f"\nUser: {query}")
        result = assistant.process_request(query)
        print(f"Assistant: {result['response']}")

if __name__ == "__main__":
    main()
