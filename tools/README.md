# Tools

Utilities, CLI tools, and integrations to enhance your Agentic AI development workflow.

## 🛠️ Development Tools

### Agent Development Utilities
- **[LangSmith](https://smith.langchain.com/)** - Debug, test, and monitor LangChain applications (2024 enhanced)
  - [Documentation](https://docs.smith.langchain.com/) | [Python SDK](https://github.com/langchain-ai/langsmith-sdk)
- **[LangGraph Studio](https://studio.langchain.com/)** - Visual IDE for building and debugging stateful agent workflows
  - [Documentation](https://langchain-ai.github.io/langgraph/tutorials/langgraph-studio/) | [Download](https://studio.langchain.com/)
- **[AutoGen Studio](https://autogen-studio.com/)** - Visual interface for building multi-agent conversations
  - [GitHub](https://github.com/microsoft/autogen/tree/main/samples/apps/autogen-studio) | [Documentation](https://microsoft.github.io/autogen/docs/autogen-studio/getting-started)
- **[Weights & Biases](https://wandb.ai/)** - Enhanced experiment tracking and monitoring for AI agents
  - [Agent Monitoring Guide](https://docs.wandb.ai/guides/integrations/langchain) | [Multi-Agent Tracking](https://docs.wandb.ai/guides/track/log)
- **[LangFuse](https://langfuse.com/)** - Open-source observability & analytics for LLM applications
  - [GitHub](https://github.com/langfuse/langfuse) | [Documentation](https://langfuse.com/docs)
- **[Helicone](https://www.helicone.ai/)** - Observability platform for LLM applications with agent support
  - [GitHub](https://github.com/Helicone/helicone) | [Documentation](https://docs.helicone.ai/)
- **[Cursor](https://cursor.sh/)** - AI-first code editor with agent development features
  - [Agent Development Templates](https://cursor.sh/features) | [Extensions](https://cursor.sh/docs)
- **[GitHub Copilot](https://github.com/features/copilot)** - AI coding assistant with agent pattern support
  - [Agent Development Guide](https://docs.github.com/en/copilot) | [Workspace Setup](https://docs.github.com/en/copilot/configuring-github-copilot/configuring-github-copilot-in-your-environment)

### Testing and Validation
- **[PromptFoo](https://www.promptfoo.dev/)** - Test and evaluate LLM outputs systematically
  - [GitHub](https://github.com/promptfoo/promptfoo) | [CLI Tool](https://www.npmjs.com/package/promptfoo)
- **[DeepEval](https://github.com/confident-ai/deepeval)** - Unit testing framework for LLMs
  - [Documentation](https://docs.confident-ai.com/) | [Python Package](https://pypi.org/project/deepeval/)
- **[Ragas](https://github.com/explodinggradients/ragas)** - Evaluation framework for RAG systems
  - [Documentation](https://docs.ragas.io/) | [Examples](https://github.com/explodinggradients/ragas/tree/main/docs/howtos)
- **[TruLens](https://www.trulens.org/)** - Evaluation and tracking for neural nets
  - [GitHub](https://github.com/truera/trulens) | [Documentation](https://trulens.org/trulens_eval/getting_started/)

### Agent Debugging & Visualization
- **[Phoenix](https://phoenix.arize.com/)** - AI observability and evaluation platform
  - [GitHub](https://github.com/Arize-ai/phoenix) | [Documentation](https://docs.arize.com/phoenix)
- **[Streamlit](https://streamlit.io/)** - Create interactive debugging interfaces for agents
  - [Agent Dashboard Tutorial](https://blog.streamlit.io/build-a-chatbot-with-streamlit-and-langchain/)
- **[Gradio](https://gradio.app/)** - Build demos and interfaces for AI agents
  - [GitHub](https://github.com/gradio-app/gradio) | [Agent Examples](https://gradio.app/guides/creating-a-chatbot-fast/)
- **[Panel](https://panel.holoviz.org/)** - Create dashboards and apps for agent monitoring
  - [GitHub](https://github.com/holoviz/panel) | [ChatBot Tutorial](https://panel.holoviz.org/tutorials/basic/pn.chat.html)

## 🔧 CLI Tools

### Agent Development CLIs
```bash
# LangChain CLI (Enhanced 2024)
pip install langchain-cli
langchain serve  # Serve LangChain apps
langchain new my-agent  # Create new project with LangGraph templates
langgraph dev  # Development server for LangGraph apps

# CrewAI CLI  
pip install crewai-cli
crewai create crew my_crew  # Create new crew
crewai run  # Run crew
crewai install  # Install crew dependencies

# OpenAI Swarm (No CLI yet, direct Python usage)
pip install git+https://github.com/openai/swarm.git
# Use directly in Python scripts

# AutoGen CLI tools
pip install pyautogen[studio]
autogen-studio ui  # Launch AutoGen Studio interface

# PydanticAI CLI
pip install pydantic-ai
# Built-in CLI tools for type-safe agent development

# DSPy CLI
pip install dspy-ai
# Python-based optimization framework

# AutoGen Studio
pip install autogenstudio
autogenstudio ui  # Launch web interface

# OpenAI CLI
pip install openai
openai api chat.completions.create  # Direct API access
```

### Development Workflow Tools
```bash
# Agent project scaffolding with Cookiecutter
pip install cookiecutter
cookiecutter https://github.com/langchain-ai/langchain-template

# Environment management with Poetry
curl -sSL https://install.python-poetry.org | python3 -
poetry new my-agent-project
poetry add langchain openai

# Docker for agent deployment
docker run -p 8000:8000 langchain/langserve-simple

# Monitoring and logging
pip install loguru rich
```

### Productivity Tools
```bash
# Code generation for agents
pip install cursor-cli  # AI-powered code editor
pip install github-copilot-cli  # AI pair programming

# Project management
pip install typer rich  # Build beautiful CLIs
pip install click  # Command line interface creation

# API testing for agent endpoints
pip install httpx requests-toolbelt
pip install postman-cli  # API testing
```

## 🔌 Integrations

### IDE Extensions
- **[GitHub Copilot](https://github.com/features/copilot)** - AI pair programmer for VS Code, JetBrains, Neovim
  - [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- **[Cursor](https://cursor.sh/)** - AI-first code editor with agent capabilities
  - [Download](https://cursor.sh/) | [Documentation](https://docs.cursor.sh/)
- **[Continue.dev](https://continue.dev/)** - Open-source AI code assistant
  - [GitHub](https://github.com/continuedev/continue) | [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=Continue.continue)
- **[Codeium](https://codeium.com/)** - Free AI code completion and chat
  - [Extensions](https://codeium.com/download) | [Documentation](https://codeium.com/docs)

### Framework Integrations
- **[LangChain Integrations](https://python.langchain.com/docs/integrations/platforms/)** - 100+ integrations
  - [Vector Stores](https://python.langchain.com/docs/integrations/vectorstores/) | [LLMs](https://python.langchain.com/docs/integrations/llms/)
- **[AutoGen Integrations](https://microsoft.github.io/autogen/docs/ecosystem/)** - Ecosystem integrations
  - [Web UI](https://github.com/microsoft/autogen/tree/main/samples/apps/autogen-studio) | [Docker](https://microsoft.github.io/autogen/docs/installation/Docker)
- **[CrewAI Tools](https://github.com/joaomdmoura/crewAI-tools)** - Ready-to-use tools for CrewAI
  - [Documentation](https://docs.crewai.com/tools/crewai-tools/) | [Examples](https://github.com/joaomdmoura/crewAI-examples)

### Cloud Platforms
- **[Vercel AI SDK](https://sdk.vercel.ai/)** - Build AI-powered applications
  - [GitHub](https://github.com/vercel/ai) | [Documentation](https://sdk.vercel.ai/docs)
- **[Replicate](https://replicate.com/)** - Run AI models in the cloud
  - [Python Client](https://github.com/replicate/replicate-python) | [API Docs](https://replicate.com/docs)
- **[Modal](https://modal.com/)** - Serverless cloud computing for AI
  - [Python SDK](https://github.com/modal-labs/modal-client) | [Documentation](https://modal.com/docs)
- **[Banana](https://www.banana.dev/)** - Serverless inference for ML models
  - [Python SDK](https://github.com/bananaml/banana-python-sdk) | [Documentation](https://docs.banana.dev/)

### Database & Vector Store Integrations
- **[Pinecone](https://www.pinecone.io/)** - Vector database for AI applications
  - [Python Client](https://github.com/pinecone-io/pinecone-python-client) | [LangChain Integration](https://python.langchain.com/docs/integrations/vectorstores/pinecone)
- **[Weaviate](https://weaviate.io/)** - Vector search engine
  - [Python Client](https://github.com/weaviate/weaviate-python-client) | [Documentation](https://weaviate.io/developers/weaviate)
- **[Chroma](https://www.trychroma.com/)** - Open-source embedding database
  - [GitHub](https://github.com/chroma-core/chroma) | [Documentation](https://docs.trychroma.com/)
- **[Qdrant](https://qdrant.tech/)** - Vector similarity search engine
  - [Python Client](https://github.com/qdrant/qdrant-client) | [Documentation](https://qdrant.tech/documentation/)

## 📊 Monitoring and Analytics

### Agent Performance Monitoring
- **[LangSmith](https://smith.langchain.com/)** - Comprehensive LLM application monitoring
  - [Tracing Guide](https://docs.smith.langchain.com/tracing) | [Evaluation Tools](https://docs.smith.langchain.com/evaluation)
- **[Weights & Biases](https://wandb.ai/)** - Experiment tracking and model monitoring
  - [LLM Monitoring](https://docs.wandb.ai/guides/prompts) | [Agent Tracking](https://docs.wandb.ai/guides/integrations/langchain)
- **[MLflow](https://mlflow.org/)** - Open-source ML lifecycle management
  - [GitHub](https://github.com/mlflow/mlflow) | [LLM Tracking](https://mlflow.org/docs/latest/llms/index.html)
- **[Neptune](https://neptune.ai/)** - Experiment tracking for ML teams
  - [LLM Monitoring](https://docs.neptune.ai/integrations/langchain/) | [GitHub](https://github.com/neptune-ai/neptune-client)

### Debugging Tools
- **[Phoenix](https://phoenix.arize.com/)** - AI observability and evaluation
  - [GitHub](https://github.com/Arize-ai/phoenix) | [LangChain Integration](https://docs.arize.com/phoenix/integrations/langchain)
- **[LangFuse](https://langfuse.com/)** - Open-source LLM observability
  - [GitHub](https://github.com/langfuse/langfuse) | [Python SDK](https://langfuse.com/docs/sdk/python)
- **[Helicone](https://www.helicone.ai/)** - LLM observability platform
  - [GitHub](https://github.com/Helicone/helicone) | [Integration Guide](https://docs.helicone.ai/getting-started/integration-method/openai-proxy)
- **[Portkey](https://portkey.ai/)** - AI gateway with observability
  - [GitHub](https://github.com/Portkey-AI/gateway) | [Documentation](https://docs.portkey.ai/)

### Cost Analytics & Optimization
- **[OpenAI Usage Dashboard](https://platform.openai.com/usage)** - Track API usage and costs
- **[Anthropic Console](https://console.anthropic.com/)** - Monitor Claude API usage
- **[LLM Cost Calculator](https://huggingface.co/spaces/philschmid/llm-pricing)** - Compare model costs
- **[Token Counter Tools](https://tiktokenizer.vercel.app/)** - Count tokens for different models

### Performance Analytics
- **[Grafana](https://grafana.com/)** - Visualization and monitoring
  - [AI/ML Dashboard Templates](https://grafana.com/grafana/dashboards/?search=ai)
- **[Prometheus](https://prometheus.io/)** - Monitoring system and time series database
  - [Python Client](https://github.com/prometheus/client_python) | [ML Metrics Guide](https://prometheus.io/docs/practices/instrumentation/#machine-learning)
- **[DataDog](https://www.datadoghq.com/)** - Infrastructure and application monitoring
  - [LLM Observability](https://docs.datadoghq.com/llm_observability/) | [Python SDK](https://github.com/DataDog/dd-trace-py)

## 🚀 Deployment Tools

### Container Solutions
- **[Docker](https://www.docker.com/)** - Containerization platform
  - [LangServe Template](https://github.com/langchain-ai/langserve) | [AutoGen Docker](https://microsoft.github.io/autogen/docs/installation/Docker)
- **[Podman](https://podman.io/)** - Daemonless container engine
  - [Documentation](https://docs.podman.io/) | [AI Workloads Guide](https://developers.redhat.com/articles/2023/05/24/how-run-ai-workloads-podman)
- **[LangServe](https://github.com/langchain-ai/langserve)** - Deploy LangChain runnables as REST APIs
  - [Documentation](https://python.langchain.com/docs/langserve) | [Templates](https://github.com/langchain-ai/langchain/tree/master/templates)

### Kubernetes & Orchestration
- **[Kubernetes](https://kubernetes.io/)** - Container orchestration
  - [AI/ML Workloads Guide](https://kubernetes.io/docs/concepts/workloads/) | [Helm Charts](https://artifacthub.io/)
- **[KubeFlow](https://www.kubeflow.org/)** - ML workflows on Kubernetes
  - [Documentation](https://www.kubeflow.org/docs/) | [Pipelines](https://www.kubeflow.org/docs/components/pipelines/)
- **[Ray Serve](https://docs.ray.io/en/latest/serve/index.html)** - Scalable model serving
  - [LLM Deployment Guide](https://docs.ray.io/en/latest/serve/tutorials/serve-ml-models.html)

### Infrastructure as Code
- **[Terraform](https://www.terraform.io/)** - Infrastructure automation
  - [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest) | [AI Infrastructure Templates](https://github.com/terraform-aws-modules)
- **[Pulumi](https://www.pulumi.com/)** - Modern infrastructure as code
  - [AI Examples](https://github.com/pulumi/examples/tree/master/ai-ml) | [Python SDK](https://github.com/pulumi/pulumi)
- **[AWS CDK](https://aws.amazon.com/cdk/)** - AWS Cloud Development Kit
  - [AI/ML Constructs](https://docs.aws.amazon.com/cdk/api/v2/python/aws_cdk.aws_sagemaker.html)
- **[Ansible](https://www.ansible.com/)** - Configuration management
  - [AI Playbooks](https://github.com/ansible/ansible-examples) | [Documentation](https://docs.ansible.com/)

### Serverless Platforms
- **[Vercel](https://vercel.com/)** - Frontend and edge functions
  - [AI SDK](https://sdk.vercel.ai/) | [Template](https://vercel.com/templates/ai)
- **[Netlify](https://www.netlify.com/)** - Web development platform
  - [Functions](https://www.netlify.com/products/functions/) | [AI Examples](https://github.com/netlify/netlify-examples)
- **[Railway](https://railway.app/)** - Infrastructure platform
  - [Templates](https://railway.app/templates) | [Documentation](https://docs.railway.app/)
- **[Render](https://render.com/)** - Cloud application platform
  - [Python Deployment](https://render.com/docs/deploy-python) | [AI Examples](https://github.com/render-examples)

### CI/CD Pipelines
- **[GitHub Actions](https://github.com/features/actions)** - Automation workflows
  - [AI/ML Actions](https://github.com/marketplace?type=actions&query=machine+learning)
  - [LangChain Deploy Action](https://github.com/marketplace/actions/deploy-langchain-app)
- **[GitLab CI](https://docs.gitlab.com/ee/ci/)** - DevOps platform
  - [ML Pipelines](https://docs.gitlab.com/ee/user/project/ml/experiment_tracking/) | [Templates](https://gitlab.com/gitlab-org/project-templates)
- **[Azure DevOps](https://azure.microsoft.com/en-us/services/devops/)** - DevOps services
  - [ML Pipelines](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-create-machine-learning-pipelines)
- **[Jenkins](https://www.jenkins.io/)** - Automation server
  - [AI/ML Plugins](https://plugins.jenkins.io/machine-learning/) | [Pipeline Examples](https://github.com/jenkinsci/pipeline-examples)

## 🔐 Security and Compliance

### Security Tools
- **[OWASP LLM Top 10](https://owasp.org/www-project-top-10-for-large-language-model-applications/)** - Security risks for LLM applications
  - [GitHub](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications)
- **[Guardrails AI](https://guardrailsai.github.io/guardrails/)** - Validate and correct LLM outputs
  - [GitHub](https://github.com/guardrails-ai/guardrails) | [Documentation](https://guardrailsai.github.io/guardrails/)
- **[NeMo Guardrails](https://github.com/NVIDIA/NeMo-Guardrails)** - Programming framework for LLM safety
  - [Documentation](https://docs.nvidia.com/nemo/guardrails/) | [Examples](https://github.com/NVIDIA/NeMo-Guardrails/tree/main/examples)
- **[LangKit](https://github.com/whylabs/langkit)** - LLM monitoring toolkit with safety features
  - [Documentation](https://langkit.readthedocs.io/) | [WhyLabs Integration](https://whylabs.ai/langkit)

### Input Validation & Sanitization
- **[Prompt Injection Detector](https://github.com/protectai/llm-guard)** - LLM security toolkit
  - [Documentation](https://llm-guard.com/) | [Python Package](https://pypi.org/project/llm-guard/)
- **[Rebuff](https://github.com/woop/rebuff)** - Prompt injection detector
  - [Documentation](https://rebuff.ai/) | [API](https://docs.rebuff.ai/)
- **[Prompt Security Scanner](https://github.com/microsoft/promptflow)** - Microsoft PromptFlow security
  - [Documentation](https://microsoft.github.io/promptflow/)

### API Security & Management
- **[Kong](https://konghq.com/)** - API gateway with security features
  - [AI Gateway Plugin](https://docs.konghq.com/hub/kong-inc/ai-proxy/) | [Rate Limiting](https://docs.konghq.com/hub/kong-inc/rate-limiting/)
- **[Postman](https://www.postman.com/)** - API development and testing
  - [Security Testing](https://learning.postman.com/docs/api-governance/api-testing/security-testing/) | [AI Collection](https://www.postman.com/templates/ai-apis/)
- **[Insomnia](https://insomnia.rest/)** - API client and testing tool
  - [Security Features](https://docs.insomnia.rest/insomnia/security)

### Compliance Helpers
- **[GDPR Compliance Kit](https://github.com/privacytools/gdpr-compliance)** - GDPR compliance tools
- **[HIPAA Compliance Guide](https://github.com/catalyzeio/hipaa-compliance)** - Healthcare compliance
- **[SOC 2 Compliance](https://github.com/JupiterOne/secops-automation-examples)** - Security compliance automation
- **[PCI DSS Tools](https://github.com/pcidss/pci-dss)** - Payment card industry compliance

### Audit & Logging
- **[Elastic Security](https://www.elastic.co/security)** - Security information and event management
  - [ML Detection Rules](https://github.com/elastic/detection-rules) | [Documentation](https://www.elastic.co/guide/en/security/current/index.html)
- **[Splunk](https://www.splunk.com/)** - Data analytics and monitoring
  - [ML Toolkit](https://splunkbase.splunk.com/app/2890/) | [Security Content](https://github.com/splunk/security_content)
- **[Fluentd](https://www.fluentd.org/)** - Data collection and logging
  - [Documentation](https://docs.fluentd.org/) | [AI Monitoring Plugins](https://www.fluentd.org/plugins)

## 📱 Mobile and Web Tools

### Web Interfaces & Demos
- **[Streamlit](https://streamlit.io/)** - Create web apps for AI agents
  - [GitHub](https://github.com/streamlit/streamlit) | [Gallery](https://streamlit.io/gallery) | [LLM Examples](https://blog.streamlit.io/tag/llms/)
- **[Gradio](https://gradio.app/)** - Build demos and interfaces
  - [GitHub](https://github.com/gradio-app/gradio) | [Guides](https://gradio.app/guides/) | [HuggingFace Spaces](https://huggingface.co/spaces)
- **[Chainlit](https://chainlit.io/)** - Build conversational AI interfaces
  - [GitHub](https://github.com/Chainlit/chainlit) | [Documentation](https://docs.chainlit.io/)
- **[Panel](https://panel.holoviz.org/)** - Create dashboards and apps
  - [GitHub](https://github.com/holoviz/panel) | [AI Examples](https://panel.holoviz.org/gallery/index.html)

### Admin Dashboards
- **[AutoGen Studio](https://github.com/microsoft/autogen/tree/main/samples/apps/autogen-studio)** - Web UI for AutoGen
  - [Installation Guide](https://microsoft.github.io/autogen/docs/ecosystem/autogen-studio)
- **[LangFlow](https://github.com/logspace-ai/langflow)** - Visual interface for LangChain
  - [Documentation](https://docs.langflow.org/) | [Demo](https://www.langflow.org/)
- **[Flowise](https://github.com/FlowiseAI/Flowise)** - Drag & drop LLM apps builder
  - [Documentation](https://docs.flowiseai.com/) | [Cloud Version](https://flowiseai.com/)

### Mobile Development
- **[React Native](https://reactnative.dev/)** - Cross-platform mobile development
  - [AI Integration Guide](https://reactnative.dev/docs/integration-with-existing-apps)
- **[Flutter](https://flutter.dev/)** - Google's UI toolkit
  - [AI/ML Integration](https://developers.google.com/ml-kit/flutter) | [LangChain Dart](https://github.com/davidmigloz/langchain_dart)
- **[Expo](https://expo.dev/)** - React Native platform
  - [AI Examples](https://github.com/expo/examples) | [Documentation](https://docs.expo.dev/)

### Voice & Speech Integration
- **[OpenAI Whisper](https://github.com/openai/whisper)** - Speech recognition
  - [Python Package](https://pypi.org/project/openai-whisper/) | [Integration Guide](https://platform.openai.com/docs/guides/speech-to-text)
- **[Eleven Labs](https://elevenlabs.io/)** - Text-to-speech API
  - [Python SDK](https://github.com/elevenlabs/elevenlabs-python) | [Documentation](https://docs.elevenlabs.io/)
- **[AssemblyAI](https://www.assemblyai.com/)** - Speech-to-text API
  - [Python SDK](https://github.com/AssemblyAI/assemblyai-python-sdk) | [Documentation](https://www.assemblyai.com/docs/)
- **[Deepgram](https://deepgram.com/)** - Voice AI platform
  - [Python SDK](https://github.com/deepgram/deepgram-python-sdk) | [Documentation](https://developers.deepgram.com/)

## Installation & Setup

### Quick Setup Scripts
```bash
# Complete AI development environment
curl -sSL https://raw.githubusercontent.com/yadavanujkumar/awesome-agentic-ai/main/scripts/setup.sh | bash

# Python environment with essential packages
pip install langchain openai anthropic streamlit gradio chainlit

# Docker development environment
docker run -p 8501:8501 -v $(pwd):/app streamlit/streamlit:latest streamlit run /app/app.py

# Jupyter environment with AI extensions
pip install jupyter langchain-experimental jupyter-ai
jupyter lab
```

### Environment Management
```bash
# Poetry for dependency management
curl -sSL https://install.python-poetry.org | python3 -
poetry init
poetry add langchain openai streamlit

# Conda for data science environments
conda create -n agentic-ai python=3.11
conda activate agentic-ai
conda install -c conda-forge langchain openai jupyter

# uv for fast Python package management
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv agentic-ai
source agentic-ai/bin/activate
uv pip install langchain openai streamlit
```

### Configuration Templates
```bash
# Environment variables template
cp .env.example .env
# Edit with your API keys:
# OPENAI_API_KEY=your_key_here
# ANTHROPIC_API_KEY=your_key_here
# LANGCHAIN_API_KEY=your_key_here

# Docker Compose for development
docker-compose up -d  # Starts all services

# Kubernetes deployment
kubectl apply -f k8s/
```

## Contributing

Want to contribute a tool or integration? Check out our [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines!

## Support

- [Documentation](https://docs.agentic-ai.dev)
- [Community Forum](https://community.agentic-ai.dev)
- [Issue Tracker](https://github.com/yadavanujkumar/Agentic-AI-Resources/issues)