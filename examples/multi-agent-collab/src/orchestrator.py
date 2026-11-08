"""
Multi-Agent Collaboration Framework
Demonstrates Hierarchical Orchestrator Pattern with Planner, Worker, and Reviewer Agents.
"""

from typing import List, Dict, Any

class PlannerAgent:
    def create_plan(self, objective: str) -> List[Dict[str, str]]:
        return [
            {"step_id": "1", "description": f"Gather input specifications for: {objective}"},
            {"step_id": "2", "description": f"Execute core business logic for: {objective}"},
            {"step_id": "3", "description": f"Validate outputs and verify safety boundaries for: {objective}"}
        ]

class WorkerAgent:
    def execute_step(self, step: Dict[str, str]) -> Dict[str, Any]:
        return {
            "step_id": step["step_id"],
            "status": "success",
            "output": f"Executed [{step['description']}] successfully."
        }

class ReviewerAgent:
    def evaluate(self, step: Dict[str, str], worker_output: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "step_id": step["step_id"],
            "approved": True,
            "feedback": "Step output meets completion criteria without errors."
        }

class MultiAgentOrchestrator:
    def __init__(self):
        self.planner = PlannerAgent()
        self.worker = WorkerAgent()
        self.reviewer = ReviewerAgent()

    def run_collaboration(self, objective: str) -> Dict[str, Any]:
        print(f"🎯 Objective: {objective}")
        plan = self.planner.create_plan(objective)
        execution_trace = []

        for step in plan:
            print(f"  ▶ [Planner] Step {step['step_id']}: {step['description']}")
            worker_result = self.worker.execute_step(step)
            print(f"    ⚙️ [Worker] {worker_result['output']}")
            review_result = self.reviewer.evaluate(step, worker_result)
            print(f"    🔍 [Reviewer] Approved: {review_result['approved']} ({review_result['feedback']})")

            execution_trace.append({
                "step": step,
                "execution": worker_result,
                "review": review_result
            })

        return {
            "objective": objective,
            "total_steps": len(plan),
            "status": "completed",
            "trace": execution_trace
        }
