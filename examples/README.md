# Examples

Real-world Agentic AI project blueprints and runnable pattern implementations.

## Included Example Directories

- **[personal-assistant](./personal-assistant/)**: Multi-tool personal assistant with calendar, email triage, task management, research tools, memory, and unit tests.
- **[coding-agent](./coding-agent/)**: Autonomous SWE / Devin-style coding agent featuring code generation, AST syntax validation, and CodeRabbit-style automated review.
- **[research-agent](./research-agent/)**: Autonomous multi-step research agent with question decomposition, evidence gathering, citation tracking, and report synthesis.
- **[multi-agent-collab](./multi-agent-collab/)**: Hierarchical multi-agent team collaboration with Planner, Worker, and Reviewer agents.
- **[agent-patterns-2026](./agent-patterns-2026/)**: Production type-safe agent schemas with PydanticAI and full `.env.example` configurations.
- **[agent-patterns-march-2026](./agent-patterns-march-2026/)**: Advanced orchestration patterns and benchmarks.

## Framework Coverage

All examples include runnable source code (`src/`), runnable demonstrations (`examples/`), dependency definitions (`requirements.txt`), and integration tests:

- **LangChain / LangGraph**: Tool calling, checkpointing, and structured outputs
- **PydanticAI**: Strict type safety and schema validation
- **Hierarchical Collaboration**: Planner / Worker / Reviewer multi-agent orchestration
- **Devin / SWE Patterns**: Code generation with automated quality checks

## Getting Started

1. Open an example directory:
   ```bash
   cd examples/personal-assistant
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the demonstration:
   ```bash
   python examples/basic_usage.py
   ```

## Contributing

Want to add your own example? See [../CONTRIBUTING.md](../CONTRIBUTING.md).
