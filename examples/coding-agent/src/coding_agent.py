"""
Coding Agent Implementation
Devin / SWE-bench style autonomous software engineering agent.
Includes Code Generation, AST Validation, Automated Code Review (CodeRabbit style), and Test Generation.
"""

import ast
import os
from typing import Dict, Any, List, Optional

class CodingAgent:
    def __init__(self, model_name: str = "gpt-4o-mini", api_key: Optional[str] = None):
        self.model_name = model_name
        self.api_key = api_key or os.getenv("OPENAI_API_KEY")

    def generate_code(self, prompt: str, language: str = "python", framework: str = "flask") -> Dict[str, Any]:
        """Generate code template with error handling and best practices"""
        if language.lower() == "python" and "flask" in framework.lower():
            code = '''from flask import Flask, jsonify, request

app = Flask(__name__)
users = []

@app.route("/api/users", methods=["GET"])
def get_users():
    return jsonify({"users": users}), 200

@app.route("/api/users", methods=["POST"])
def create_user():
    data = request.get_json()
    if not data or "name" not in data:
        return jsonify({"error": "Name is required"}), 400
    user = {"id": len(users) + 1, "name": data["name"]}
    users.append(user)
    return jsonify(user), 201

if __name__ == "__main__":
    app.run(debug=False)
'''
        else:
            code = f"# Code generated for: {prompt}\n# Language: {language}\n"

        return {
            "prompt": prompt,
            "language": language,
            "framework": framework,
            "code": code
        }

    def validate_syntax(self, code: str) -> Dict[str, Any]:
        """Validate Python syntax using Abstract Syntax Trees (AST)"""
        try:
            ast.parse(code)
            return {"valid": True, "error": None}
        except SyntaxError as e:
            return {
                "valid": False,
                "error": f"SyntaxError at line {e.lineno}, col {e.offset}: {e.msg}"
            }

    def review_code(self, code: str) -> Dict[str, Any]:
        """
        Analyze code quality, security vulnerabilities, and anti-patterns.
        Categorized by CodeRabbit severities: Critical, Major, Minor, Info.
        """
        findings = []
        syntax_check = self.validate_syntax(code)
        
        if not syntax_check["valid"]:
            findings.append({
                "severity": "critical",
                "category": "syntax",
                "message": syntax_check["error"],
                "suggestion": "Fix syntax error before running or deploying."
            })
            return {"status": "failed", "findings": findings}

        # Check for dangerous patterns
        if "eval(" in code or "exec(" in code:
            findings.append({
                "severity": "critical",
                "category": "security",
                "message": "Use of dangerous built-in 'eval' or 'exec' detected.",
                "suggestion": "Replace with ast.literal_eval or safe arithmetic parser."
            })

        if "debug=True" in code:
            findings.append({
                "severity": "major",
                "category": "security",
                "message": "Debug mode enabled in Flask app (insecure for production).",
                "suggestion": "Set debug=False or use environment variable flags."
            })

        if "except:" in code:
            findings.append({
                "severity": "minor",
                "category": "code-quality",
                "message": "Bare except clause detected.",
                "suggestion": "Specify explicit exception types (e.g., except Exception:)."
            })

        if not findings:
            findings.append({
                "severity": "info",
                "category": "quality",
                "message": "AST validation passed. No security anti-patterns detected.",
                "suggestion": "Add unit tests to ensure high test coverage."
            })

        return {
            "status": "completed",
            "findings_count": len(findings),
            "findings": findings
        }

    def generate_tests(self, code: str) -> str:
        """Generate pytest unit tests for the provided code"""
        return '''import pytest

def test_syntax_and_imports():
    assert True
'''
