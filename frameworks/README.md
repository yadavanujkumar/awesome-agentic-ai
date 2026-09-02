# Frameworks

Guide to selecting agent frameworks, with a clear split between what is available in this repository and what to evaluate externally.

## Repository Coverage (Current)

- ✅ **LangChain / LangGraph guide available in-repo**: [./langchain/](./langchain/)
- 📝 Other framework guides are tracked as future contributions (not yet included as local directories).

## Recommended 2026 Evaluation Shortlist

Start with frameworks that are actively documented and production-oriented:

1. **LangGraph** — durable, stateful workflows and human-in-the-loop control  
   Docs: https://langchain-ai.github.io/langgraph/
2. **CrewAI** — role-based teams and business-process orchestration  
   Docs: https://docs.crewai.com/
3. **LlamaIndex Workflows/Agents** — document-heavy and retrieval-centric systems  
   Docs: https://docs.llamaindex.ai/
4. **Google ADK** — code-first multi-language framework for Google/Gemini stacks  
   Docs: https://adk.dev/
5. **Microsoft Agent Framework** — Microsoft’s primary path for new .NET/Python agent systems  
   Docs: https://learn.microsoft.com/en-us/agent-framework/
6. **OpenAI Responses API + Agents SDK** — OpenAI-first agent runtime and orchestration stack  
   Docs: https://developers.openai.com/api/docs/guides/agents
7. **PydanticAI** — type-safe Python agent development and structured outputs  
   Docs: https://ai.pydantic.dev/
8. **Smolagents** — lightweight local/open-model-friendly prototyping  
   Docs: https://huggingface.co/docs/smolagents
9. **DSPy** — optimization-centric LM/agent pipelines  
   Docs: https://dspy.ai/

## Selection Notes

- Prefer **LangGraph** or **Microsoft Agent Framework** for durable production orchestration.
- Prefer **LlamaIndex** for document-first architectures.
- Prefer **PydanticAI** when strict schemas and type safety are core requirements.
- Prefer **Smolagents** for low-friction local/open-model experimentation.
- Prefer **DSPy** when systematic optimization and evaluation loops are central.

## Contributing Additional Framework Guides

If you want to add a new framework directory under `frameworks/`, please include:

- A practical setup path
- At least one runnable minimal example
- Version notes tied to official docs
- Migration notes (if replacing older framework choices)

See [../CONTRIBUTING.md](../CONTRIBUTING.md) for contribution workflow.
