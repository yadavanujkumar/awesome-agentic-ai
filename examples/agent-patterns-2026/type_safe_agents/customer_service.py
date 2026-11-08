"""
Type-Safe Customer Service Agent using PydanticAI
Demonstrates 2026 patterns for production-ready agents
"""

from datetime import datetime, timezone
import os
import asyncio
from typing import List, Optional, Literal
from pydantic import BaseModel, Field
from pydantic_ai import Agent


class CustomerQuery(BaseModel):
    """Structured customer query with validation"""
    customer_id: str = Field(..., description="Unique customer identifier")
    query_type: Literal["billing", "technical", "general"] = Field(
        ..., description="Type of customer query"
    )
    message: str = Field(..., min_length=10, description="Customer message")
    priority: Literal["low", "medium", "high"] = Field(
        default="medium", description="Query priority level"
    )
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))


class CustomerResponse(BaseModel):
    """Structured response with metadata"""
    response_text: str = Field(..., description="Agent response to customer")
    confidence_score: float = Field(
        ..., ge=0.0, le=1.0, description="Confidence in response accuracy"
    )
    suggested_actions: List[str] = Field(
        default_factory=list, description="Recommended follow-up actions"
    )
    escalation_required: bool = Field(
        default=False, description="Whether human escalation is needed"
    )
    estimated_resolution_time: Optional[str] = Field(
        default=None, description="Expected time to resolve issue"
    )
    response_id: str = Field(..., description="Unique response identifier")


class CustomerServiceAgent:
    """Type-safe customer service agent with PydanticAI"""
    
    def __init__(self, model_name: str = 'openai:gpt-4o-mini'):
        # Initialize the agent with type-safe deps and result type
        self.agent = Agent(
            model=model_name,
            result_type=CustomerResponse,
            deps_type=dict,
            system_prompt=self._get_system_prompt()
        )
    
    def _get_system_prompt(self) -> str:
        return """
        You are a professional customer service agent. 
        
        Guidelines:
        - Always be helpful, polite, and professional
        - Provide accurate information based on company policies
        - Escalate complex issues to human agents when necessary
        - Suggest practical next steps for the customer
        - Estimate resolution times realistically
        
        For billing queries: Focus on account information and payment issues
        For technical queries: Provide troubleshooting steps and solutions
        For general queries: Address the customer's concern comprehensively
        """
    
    async def handle_customer_query(self, query: CustomerQuery) -> CustomerResponse:
        """Process customer query with full type safety"""
        
        # Prepare typed context for the agent
        context = {
            "customer_id": query.customer_id,
            "query_type": query.query_type,
            "priority": query.priority,
            "timestamp": query.timestamp.isoformat()
        }
        
        # Run the agent with typed input/output
        response = await self.agent.run(
            user_prompt=f"""
            Customer Query: {query.message}
            Query Type: {query.query_type}
            Priority: {query.priority}
            
            Please provide a helpful response with appropriate actions and escalation assessment.
            """,
            message_history=[],
            deps=context
        )
        
        return response.data


# Usage example and testing
async def main():
    """Example usage of type-safe customer service agent"""
    if not os.getenv("OPENAI_API_KEY"):
        print("ℹ️ Note: OPENAI_API_KEY not set in environment. Running schema validation test only.")
        test_query = CustomerQuery(
            customer_id="CUST_001",
            query_type="billing",
            message="I was charged twice for my subscription this month. Can you help me understand why?",
            priority="high"
        )
        print("✅ CustomerQuery validation passed successfully:")
        print(test_query.model_dump_json(indent=2))
        return

    # Initialize agent
    service_agent = CustomerServiceAgent()
    
    # Example customer queries
    test_queries = [
        CustomerQuery(
            customer_id="CUST_001",
            query_type="billing",
            message="I was charged twice for my subscription this month. Can you help me understand why?",
            priority="high"
        ),
        CustomerQuery(
            customer_id="CUST_002", 
            query_type="technical",
            message="My app keeps crashing when I try to export data. I've tried restarting but it doesn't work.",
            priority="medium"
        ),
        CustomerQuery(
            customer_id="CUST_003",
            query_type="general",
            message="I want to upgrade my plan but I'm not sure which features I need. Can you help me choose?",
            priority="low"
        )
    ]
    
    # Process each query
    for i, query in enumerate(test_queries, 1):
        print(f"\n{'='*50}")
        print(f"Processing Query {i}")
        print(f"{'='*50}")
        
        try:
            response = await service_agent.handle_customer_query(query)
            print(f"Customer ID: {query.customer_id}")
            print(f"Query Type: {query.query_type}")
            print(f"Priority: {query.priority}")
            print(f"\nCustomer Message:\n  {query.message}")
            print(f"\nAgent Response:\n  {response.response_text}")
            print(f"\nConfidence Score: {response.confidence_score:.2f}")
            print(f"Escalation Required: {response.escalation_required}")
            
            if response.suggested_actions:
                print(f"\nSuggested Actions:")
                for action in response.suggested_actions:
                    print(f"  - {action}")
            
            if response.estimated_resolution_time:
                print(f"\nEstimated Resolution Time: {response.estimated_resolution_time}")
            
            print(f"\nResponse ID: {response.response_id}")
            
        except Exception as e:
            print(f"Error processing query: {str(e)}")


if __name__ == "__main__":
    asyncio.run(main())
