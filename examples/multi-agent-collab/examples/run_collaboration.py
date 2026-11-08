import sys
from pathlib import Path

# Add src to sys.path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.orchestrator import MultiAgentOrchestrator

def main():
    orchestrator = MultiAgentOrchestrator()
    print("🤝 Initializing Multi-Agent Collaboration Session...\n")
    
    objective = "Deploy a secure microservice with automated testing and code review"
    result = orchestrator.run_collaboration(objective)
    print("\n✅ Multi-Agent Collaboration Session Finished:")
    print(f"Status: {result['status']} ({result['total_steps']} steps executed)")

if __name__ == "__main__":
    main()
