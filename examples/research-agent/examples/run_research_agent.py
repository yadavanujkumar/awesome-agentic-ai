import sys
from pathlib import Path

# Add src to sys.path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.research_agent import ResearchAgent

def main():
    agent = ResearchAgent()
    topic = "Model Context Protocol (MCP) in Multi-Agent Production Systems"
    print(f"🔬 Starting Research on: '{topic}'...\n")
    
    result = agent.conduct_research(topic)
    print(result["report_markdown"])

if __name__ == "__main__":
    main()
