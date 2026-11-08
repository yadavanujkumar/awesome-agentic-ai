import sys
from pathlib import Path

# Add src to sys.path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.coding_agent import CodingAgent

def main():
    agent = CodingAgent()
    print("🤖 Coding Agent initialized.\n")
    
    # Generate code
    prompt = "Create a REST API for user management in Python using Flask"
    result = agent.generate_code(prompt, language="python", framework="flask")
    print("📝 Generated Code:")
    print("-" * 50)
    print(result["code"])
    print("-" * 50)
    
    # Review code
    print("\n🔍 Running CodeRabbit-style Automated Code Review:")
    review = agent.review_code(result["code"])
    for finding in review["findings"]:
        print(f"[{finding['severity'].upper()}] ({finding['category']}): {finding['message']}")
        print(f"  Suggestion: {finding['suggestion']}")

if __name__ == "__main__":
    main()
