# CodeRabbit AI Code Review & Agentic Review Workflows

AI-powered code review enables developers and autonomous coding agents to implement features, audit code for security and quality, and remediate issues in self-healing feedback loops.

---

## 🌟 Why Agentic Code Review?

Traditional static analysis (linters) catches formatting and simple AST rules, but misses semantic bugs, subtle security vulnerabilities, business logic errors, and architectural anti-patterns. 

Integrating **CodeRabbit** into an autonomous agent pipeline provides:
- **Prioritized Severities**: `critical`, `major`, `minor`, `trivial`, `info`.
- **Machine-Readable Review**: `--agent` NDJSON output specifically designed for agent consumption.
- **Autonomous Autofix Loop**: Coding agents can parse findings, generate targeted diffs, and re-run reviews to verify fixes before submitting pull requests.

```
┌─────────────────┐      ┌─────────────────────────┐      ┌───────────────────────┐
│  Coding Agent   │ ───> │  CodeRabbit CLI Review  │ ───> │   Parse NDJSON Feed   │
│ (Implements PR) │      │ (review --agent)        │      │ (Critical/Major first)│
└─────────────────┘      └─────────────────────────┘      └───────────────────────┘
         ▲                                                            │
         │                                                            ▼
         └────────────────── Auto-Apply Fixes ────────────────────────┘
```

---

## 🚀 CodeRabbit CLI Setup

### 1. Installation
Install the official CodeRabbit CLI binary via package manager or verified binary:
- **macOS / Linux (Homebrew)**: `brew install coderabbitai/tap/coderabbit`
- **Windows**: Download official binary or install via package manager from [CodeRabbit CLI Docs](https://docs.coderabbit.ai/cli).
- **Verify Installation**:
  ```bash
  coderabbit --version
  ```

### 2. Authentication
Before running automated reviews:
```bash
# Check current authentication status in machine-readable format
coderabbit auth status --agent

# If not authenticated, initiate browser sign-in
coderabbit auth login
```

---

## 🛠️ CLI Review Scopes & Commands

Use `--agent` to produce structured NDJSON output suitable for automated pipelines:

| Review Goal | Command | Description |
| :--- | :--- | :--- |
| **Default Review** | `coderabbit review --agent` | Reviews committed, staged, and tracked changes |
| **Uncommitted Changes** | `coderabbit review --agent --uncommitted` | Inspects current unstaged & staged working edits |
| **Include Untracked** | `coderabbit review --agent --include-untracked` | Includes newly created, non-git-tracked files |
| **Target Branch Diff** | `coderabbit review --agent --base main` | Compares current branch changes against `main` |
| **Commit Range** | `coderabbit review --agent --base-commit <HASH>` | Compares against a specific ancestor commit |
| **Subdirectory Scope** | `coderabbit review --agent --dir path/to/dir` | Scopes analysis to an initialized subfolder |

---

## 🤖 The Autonomous "Generate-Review-Fix" Cycle

Autonomous SWE agents (like Devin, SWE-bench bots, or local coding agents) follow this 5-step cycle:

```python
import subprocess
import json

def run_agentic_review() -> list:
    """Execute CodeRabbit review and parse structured findings"""
    cmd = ["coderabbit", "review", "--agent", "--uncommitted"]
    process = subprocess.run(cmd, capture_output=True, text=True)
    
    findings = []
    for line in process.stdout.splitlines():
        if line.strip():
            try:
                record = json.loads(line)
                if record.get("type") == "finding":
                    findings.append(record)
            except json.JSONDecodeError:
                continue
    return findings

def prioritize_findings(findings: list) -> list:
    """Prioritize Critical and Major security/correctness issues first"""
    severity_order = {"critical": 0, "major": 1, "minor": 2, "trivial": 3, "info": 4}
    return sorted(findings, key=lambda f: severity_order.get(f.get("severity", "info"), 5))
```

### Finding Remediation Order
1. **Critical**: Remote Code Execution (e.g. `eval()`), SQL injections, exposed credentials, authentication bypasses.
2. **Major**: Unhandled exceptions, deadlocks, race conditions, memory leaks, broken API contracts.
3. **Minor**: Anti-patterns, non-standard error codes, deprecated imports, missing type hints.
4. **Info / Trivial**: Formatting suggestions, naming clarity, docstring enhancements.

---

## ⚙️ Configuration: `.coderabbit.yaml`

Customize review behavior across your repository by placing `.coderabbit.yaml` in the root directory:

```yaml
# yaml-language-server: $schema=https://coderabbit.ai/integrations/schema.v2.json
version: "2"
language: "en-US"
reviews:
  profile: "chill"  # Options: "assertive", "chill"
  request_changes_workflow: false
  high_level_summary: true
  auto_review:
    enabled: true
    ignore_title_keywords:
      - "WIP"
      - "draft"
    drafts: false
  path_filters:
    - "!**/dist/**"
    - "!**/node_modules/**"
    - "!**/vendor/**"
  tools:
    shellcheck:
      enabled: true
    ruff:
      enabled: true
    markdownlint:
      enabled: true
```

---

## 🔄 GitHub Actions Integration

Automate PR reviews on every pull request:

```yaml
# .github/workflows/coderabbit.yml
name: CodeRabbit Review

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  review:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: CodeRabbit PR Review
        uses: coderabbitai/action@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          coderabbit_api_key: ${{ secrets.CODERABBIT_API_KEY }}
```

---

## 📚 References & Next Steps

- [Official CodeRabbit Documentation](https://docs.coderabbit.ai/)
- [Coding Agent Example Implementation](../../examples/coding-agent/)
- [Contributing Guidelines](../../CONTRIBUTING.md)
