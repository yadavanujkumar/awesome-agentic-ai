# Tool Integration Guide

Comprehensive guide for integrating external tools and APIs with AI agents.

## 🌟 Real-World Tool Integration Examples (February 2026)

### Production Tool Usage Statistics
- **GitHub Copilot**: Integrates with 500+ VSCode extensions, Git, NPM
- **Intercom Fin**: 20+ integrated tools (CRM, knowledge base, ticketing)
- **Cursor**: File system, terminal, Git, linters, formatters
- **Perplexity Pro**: Search engines, citations, knowledge graphs
- **Zapier AI Actions**: 6,000+ app integrations available

### Most Common Production Tools by Use Case
```
Customer Service Agents:
1. CRM Integration (Salesforce, HubSpot): 95% of deployments
2. Knowledge Base Search (Zendesk, Intercom): 90%
3. Ticketing Systems (Jira, Linear): 85%
4. Email/Slack Notifications: 80%
5. Payment Processing (Stripe): 60%

Developer Agents:
1. File System Operations: 100%
2. Git Operations: 95%
3. Terminal/Shell Commands: 90%
4. Code Linters/Formatters: 85%
5. Package Managers (npm, pip): 80%

Research Agents:
1. Web Search APIs: 100%
2. Academic Databases (arXiv, PubMed): 90%
3. PDF Processing: 85%
4. Citation Management: 75%
5. Data Visualization: 70%
```

## 🛠️ Tool Integration Fundamentals

### What Makes a Good Agent Tool?

1. **Deterministic**: Same input produces consistent output
2. **Well-Documented**: Clear parameter descriptions and examples
3. **Error-Handled**: Graceful failure modes and error messages
4. **Scoped**: Does one thing well rather than many things poorly
5. **Fast**: Responds quickly to avoid conversation delays

### Tool Categories

| Category | Examples | Use Cases |
|----------|----------|-----------|
| **Search & Retrieval** | Google Search, Database queries | Information gathering |
| **Data Processing** | CSV parser, Image analyzer | Data transformation |
| **Communication** | Email, Slack, SMS | External notifications |
| **File Operations** | Read/write files, PDF processing | Document handling |
| **APIs & Web Services** | REST APIs, GraphQL | External service integration |
| **Computation** | Calculator, Math solver | Calculations and analysis |

---

## 🦜 LangChain Tool Integration

### Creating Custom Tools

#### Method 1: Tool Decorator
```python
from langchain.tools import tool

@tool
def get_weather(city: str) -> str:
    """Get current weather for a city.
    
    Args:
        city: Name of the city to get weather for
        
    Returns:
        Weather description string
    """
    # Implementation here
    api_key = "your_api_key"
    response = requests.get(f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}")
    data = response.json()
    return f"Weather in {city}: {data['weather'][0]['description']}, {data['main']['temp']}°K"
```

#### Method 2: BaseTool Class
```python
from langchain.tools import BaseTool
from typing import Optional, Type
from pydantic import BaseModel, Field

class WeatherInput(BaseModel):
    city: str = Field(description="Name of the city")

class WeatherTool(BaseTool):
    name = "get_weather"
    description = "Useful for getting current weather information for a specific city"
    args_schema: Type[BaseModel] = WeatherInput

    def _run(self, city: str) -> str:
        # Implementation here
        return f"Weather data for {city}"

    async def _arun(self, city: str) -> str:
        # Async implementation
        raise NotImplementedError("Async not implemented")
```

### Using Tools with Agents

```python
from langchain.agents import initialize_agent, AgentType
from langchain.llms import OpenAI

# Initialize tools
tools = [get_weather, WebSearchTool(), CalculatorTool()]

# Create agent
agent = initialize_agent(
    tools=tools,
    llm=OpenAI(temperature=0),
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)

# Use the agent
result = agent.run("What's the weather in New York and what's 25 + 37?")
```

### Pre-built LangChain Tools

```python
from langchain.tools import (
    DuckDuckGoSearchRun,
    ShellTool,
    PythonREPLTool,
    WikipediaQueryRun,
    ArxivQueryRun
)

# Search tools
search = DuckDuckGoSearchRun()

# Shell execution (use with caution!)
shell = ShellTool()

# Python execution
python_repl = PythonREPLTool()

# Knowledge bases
wikipedia = WikipediaQueryRun(api_wrapper=WikipediaAPIWrapper())
arxiv = ArxivQueryRun()
```

---

## 🤖 AutoGen Tool Integration

### Function Calling in AutoGen

```python
import autogen
from typing import Annotated, Literal

def get_stock_price(symbol: Annotated[str, "Stock symbol"]) -> str:
    """Get current stock price for a symbol."""
    # Implementation
    return f"Current price of {symbol}: $150.25"

def send_email(
    to: Annotated[str, "Recipient email"],
    subject: Annotated[str, "Email subject"], 
    body: Annotated[str, "Email body"]
) -> str:
    """Send an email to specified recipient."""
    # Implementation
    return f"Email sent to {to} with subject: {subject}"

# Configure agent with tools
assistant = autogen.AssistantAgent(
    name="assistant",
    system_message="You are a helpful assistant with access to tools.",
    llm_config={
        "config_list": [{"model": "gpt-4", "api_key": "your-key"}],
        "functions": [
            {
                "name": "get_stock_price",
                "description": "Get current stock price",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "symbol": {"type": "string", "description": "Stock symbol"}
                    },
                    "required": ["symbol"]
                }
            }
        ]
    }
)

# Register the function
assistant.register_function(
    function_map={"get_stock_price": get_stock_price}
)
```

### Multi-Agent Tool Sharing

```python
# Shared tool registry
def create_shared_tools():
    return {
        "calculator": lambda x: eval(x),  # Simple calculator
        "weather": get_weather,
        "search": web_search
    }

# Agent with shared tools
def create_agent_with_tools(name, role, tools):
    return autogen.AssistantAgent(
        name=name,
        system_message=f"You are a {role}. Use available tools to help solve problems.",
        llm_config={
            "config_list": [{"model": "gpt-4", "api_key": "your-key"}],
            "functions": [tool_to_function_schema(tool) for tool in tools.values()]
        },
        function_map=tools
    )
```

---

## ⚡ CrewAI Tool Integration

### Creating CrewAI Tools

```python
from crewai_tools import BaseTool
from typing import Type
from pydantic import BaseModel, Field

class WeatherToolInput(BaseModel):
    city: str = Field(..., description="Name of the city to get weather for")

class WeatherTool(BaseTool):
    name: str = "Weather Tool"
    description: str = "Useful for getting weather information for a specific city"
    args_schema: Type[BaseModel] = WeatherToolInput

    def _run(self, city: str) -> str:
        # Your weather API implementation
        return f"The weather in {city} is sunny and 25°C"
```

### Using Tools with CrewAI Agents

```python
from crewai import Agent, Task, Crew
from crewai_tools import SerperDevTool, WebsiteSearchTool

# Initialize tools
search_tool = SerperDevTool()
web_tool = WebsiteSearchTool()
weather_tool = WeatherTool()

# Create agent with tools
researcher = Agent(
    role='Research Analyst',
    goal='Gather comprehensive information on given topics',
    backstory="Expert at finding and analyzing information from various sources",
    tools=[search_tool, web_tool, weather_tool],
    verbose=True
)

# Create task
research_task = Task(
    description="Research the latest trends in AI and the weather in San Francisco",
    agent=researcher,
    expected_output="A detailed report with AI trends and current weather"
)

# Execute
crew = Crew(agents=[researcher], tasks=[research_task])
result = crew.kickoff()
```

---

## 🦙 LlamaIndex Tool Integration

### Creating Tools for LlamaIndex

```python
from llama_index.tools import FunctionTool
from llama_index.agent import ReActAgent

def multiply(a: int, b: int) -> int:
    """Multiply two integers and return the result."""
    return a * b

def add(a: int, b: int) -> int:
    """Add two integers and return the result."""
    return a + b

# Convert functions to tools
multiply_tool = FunctionTool.from_defaults(fn=multiply)
add_tool = FunctionTool.from_defaults(fn=add)

# Create agent with tools
agent = ReActAgent.from_tools([multiply_tool, add_tool], verbose=True)

# Use the agent
response = agent.chat("What is 121 * 3? Also, what is 5 + 8?")
```

### Custom Tool Implementation

```python
from llama_index.tools import BaseTool
from llama_index.tools.tool_spec.base import BaseToolSpec

class DatabaseTool(BaseTool):
    def __init__(self, connection_string: str):
        self.connection = connect_to_db(connection_string)
    
    @property
    def metadata(self):
        return ToolMetadata(
            name="database_query",
            description="Execute SQL queries on the database"
        )
    
    def call(self, query: str) -> str:
        try:
            result = self.connection.execute(query)
            return str(result.fetchall())
        except Exception as e:
            return f"Error executing query: {str(e)}"
```

---

## 🔧 Common Tool Patterns

### 1. API Wrapper Tool

```python
import requests
from typing import Optional, Dict, Any

class APITool:
    def __init__(self, base_url: str, api_key: Optional[str] = None):
        self.base_url = base_url
        self.headers = {"Authorization": f"Bearer {api_key}"} if api_key else {}
    
    def get(self, endpoint: str, params: Optional[Dict] = None) -> Dict[Any, Any]:
        """Make GET request to API endpoint."""
        response = requests.get(
            f"{self.base_url}/{endpoint}",
            headers=self.headers,
            params=params
        )
        response.raise_for_status()
        return response.json()
    
    def post(self, endpoint: str, data: Dict) -> Dict[Any, Any]:
        """Make POST request to API endpoint."""
        response = requests.post(
            f"{self.base_url}/{endpoint}",
            headers=self.headers,
            json=data
        )
        response.raise_for_status()
        return response.json()

# Usage
api_tool = APITool("https://api.example.com", "your-api-key")
```

### 2. File Operations Tool

```python
import os
import json
import csv
from pathlib import Path

class FileOperationsTool:
    @staticmethod
    def read_text_file(file_path: str) -> str:
        """Read content from a text file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                return file.read()
        except FileNotFoundError:
            return f"File not found: {file_path}"
        except Exception as e:
            return f"Error reading file: {str(e)}"
    
    @staticmethod
    def write_text_file(file_path: str, content: str) -> str:
        """Write content to a text file."""
        try:
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(content)
            return f"Successfully wrote to {file_path}"
        except Exception as e:
            return f"Error writing file: {str(e)}"
    
    @staticmethod
    def read_csv(file_path: str, max_rows: int = 100) -> str:
        """Read CSV file and return formatted data."""
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                reader = csv.reader(file)
                rows = [row for i, row in enumerate(reader) if i < max_rows]
                return json.dumps(rows, indent=2)
        except Exception as e:
            return f"Error reading CSV: {str(e)}"
```

### 3. Database Tool

```python
import sqlite3
from typing import List, Tuple, Any

class DatabaseTool:
    def __init__(self, db_path: str):
        self.db_path = db_path
    
    def execute_query(self, query: str) -> str:
        """Execute SQL query and return results."""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                cursor.execute(query)
                
                if query.strip().upper().startswith('SELECT'):
                    results = cursor.fetchall()
                    columns = [description[0] for description in cursor.description]
                    return self._format_results(columns, results)
                else:
                    conn.commit()
                    return f"Query executed successfully. Rows affected: {cursor.rowcount}"
        except Exception as e:
            return f"Database error: {str(e)}"
    
    def _format_results(self, columns: List[str], results: List[Tuple[Any, ...]]) -> str:
        """Format query results as a readable string."""
        if not results:
            return "No results found."
        
        formatted = f"Columns: {', '.join(columns)}\n"
        formatted += "-" * 50 + "\n"
        for row in results:
            formatted += " | ".join(str(cell) for cell in row) + "\n"
        
        return formatted
```

### 4. Email Tool

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import List, Optional

class EmailTool:
    def __init__(self, smtp_server: str, smtp_port: int, username: str, password: str):
        self.smtp_server = smtp_server
        self.smtp_port = smtp_port
        self.username = username
        self.password = password
    
    def send_email(
        self,
        to_addresses: List[str],
        subject: str,
        body: str,
        cc_addresses: Optional[List[str]] = None,
        is_html: bool = False
    ) -> str:
        """Send email to specified recipients."""
        try:
            msg = MIMEMultipart()
            msg['From'] = self.username
            msg['To'] = ', '.join(to_addresses)
            msg['Subject'] = subject
            
            if cc_addresses:
                msg['Cc'] = ', '.join(cc_addresses)
            
            msg.attach(MIMEText(body, 'html' if is_html else 'plain'))
            
            with smtplib.SMTP(self.smtp_server, self.smtp_port) as server:
                server.starttls()
                server.login(self.username, self.password)
                
                all_recipients = to_addresses + (cc_addresses or [])
                server.send_message(msg, to_addrs=all_recipients)
            
            return f"Email sent successfully to {len(all_recipients)} recipients"
        
        except Exception as e:
            return f"Failed to send email: {str(e)}"
```

---

## 🛡️ Tool Security & Best Practices

### 1. Input Validation

```python
import re
from typing import Any

def validate_tool_input(input_value: Any, expected_type: type, pattern: str = None) -> bool:
    """Validate tool input for security and correctness."""
    
    # Type checking
    if not isinstance(input_value, expected_type):
        raise ValueError(f"Expected {expected_type.__name__}, got {type(input_value).__name__}")
    
    # Pattern validation for strings
    if pattern and isinstance(input_value, str):
        if not re.match(pattern, input_value):
            raise ValueError(f"Input doesn't match expected pattern: {pattern}")
    
    # Length limits
    if isinstance(input_value, str) and len(input_value) > 1000:
        raise ValueError("Input too long (max 1000 characters)")
    
    return True

# Example usage in tool
def safe_web_search(query: str) -> str:
    """Perform web search with input validation."""
    try:
        validate_tool_input(query, str, r'^[a-zA-Z0-9\s\-_.,!?]+$')
        # Perform search
        return perform_search(query)
    except ValueError as e:
        return f"Invalid input: {str(e)}"
```

### 2. Rate Limiting

```python
import time
from collections import defaultdict
from typing import Dict

class RateLimitedTool:
    def __init__(self, max_calls_per_minute: int = 60):
        self.max_calls = max_calls_per_minute
        self.call_times: Dict[str, list] = defaultdict(list)
    
    def is_rate_limited(self, tool_name: str) -> bool:
        """Check if tool has exceeded rate limit."""
        now = time.time()
        minute_ago = now - 60
        
        # Clean old entries
        self.call_times[tool_name] = [
            call_time for call_time in self.call_times[tool_name]
            if call_time > minute_ago
        ]
        
        # Check rate limit
        if len(self.call_times[tool_name]) >= self.max_calls:
            return True
        
        # Record this call
        self.call_times[tool_name].append(now)
        return False
    
    def call_with_rate_limit(self, tool_name: str, tool_func, *args, **kwargs):
        """Execute tool function with rate limiting."""
        if self.is_rate_limited(tool_name):
            return f"Rate limit exceeded for {tool_name}. Please wait."
        
        return tool_func(*args, **kwargs)
```

### 3. Error Handling

```python
from functools import wraps
import logging

def safe_tool_execution(func):
    """Decorator to safely execute tools with comprehensive error handling."""
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            result = func(*args, **kwargs)
            return result
        except ConnectionError as e:
            logging.error(f"Connection error in {func.__name__}: {str(e)}")
            return f"Connection error: Unable to reach external service. Please try again later."
        except TimeoutError as e:
            logging.error(f"Timeout error in {func.__name__}: {str(e)}")
            return f"Timeout error: Operation took too long. Please try with a simpler request."
        except ValueError as e:
            logging.error(f"Value error in {func.__name__}: {str(e)}")
            return f"Input error: {str(e)}"
        except Exception as e:
            logging.error(f"Unexpected error in {func.__name__}: {str(e)}")
            return f"An unexpected error occurred. Please contact support if this persists."
    
    return wrapper

# Usage
@safe_tool_execution
def risky_api_call(endpoint: str, data: dict) -> str:
    """Make API call that might fail."""
    # Implementation that might raise various exceptions
    pass
```

---

## 📊 Tool Performance Monitoring

### Tool Usage Analytics

```python
import time
from collections import defaultdict
from dataclasses import dataclass
from typing import Dict, List

@dataclass
class ToolMetrics:
    call_count: int = 0
    total_time: float = 0.0
    error_count: int = 0
    success_count: int = 0

class ToolMonitor:
    def __init__(self):
        self.metrics: Dict[str, ToolMetrics] = defaultdict(ToolMetrics)
    
    def track_tool_call(self, tool_name: str, execution_time: float, success: bool):
        """Track tool performance metrics."""
        metrics = self.metrics[tool_name]
        metrics.call_count += 1
        metrics.total_time += execution_time
        
        if success:
            metrics.success_count += 1
        else:
            metrics.error_count += 1
    
    def get_tool_stats(self, tool_name: str) -> Dict:
        """Get performance statistics for a tool."""
        metrics = self.metrics[tool_name]
        if metrics.call_count == 0:
            return {"message": f"No data for tool: {tool_name}"}
        
        return {
            "tool_name": tool_name,
            "total_calls": metrics.call_count,
            "success_rate": metrics.success_count / metrics.call_count,
            "average_execution_time": metrics.total_time / metrics.call_count,
            "total_execution_time": metrics.total_time,
            "error_count": metrics.error_count
        }
    
    def get_all_stats(self) -> List[Dict]:
        """Get stats for all monitored tools."""
        return [self.get_tool_stats(tool_name) for tool_name in self.metrics.keys()]

# Usage with decorator
monitor = ToolMonitor()

def monitored_tool(tool_name: str):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start_time = time.time()
            success = True
            try:
                result = func(*args, **kwargs)
                return result
            except Exception as e:
                success = False
                raise e
            finally:
                execution_time = time.time() - start_time
                monitor.track_tool_call(tool_name, execution_time, success)
        return wrapper
    return decorator

@monitored_tool("weather_api")
def get_weather(city: str) -> str:
    # Tool implementation
    pass
```

---

## 🔗 Tool Composition Patterns

### 1. Sequential Tool Chain

```python
class ToolChain:
    def __init__(self, tools: List[callable]):
        self.tools = tools
    
    def execute(self, initial_input: Any) -> Any:
        """Execute tools in sequence, passing output to next tool."""
        current_input = initial_input
        
        for i, tool in enumerate(self.tools):
            try:
                current_input = tool(current_input)
            except Exception as e:
                return f"Error in tool {i+1}: {str(e)}"
        
        return current_input

# Example usage
def extract_text(file_path: str) -> str:
    # Extract text from file
    pass

def summarize_text(text: str) -> str:
    # Summarize the text
    pass

def translate_text(text: str) -> str:
    # Translate to another language
    pass

# Create and execute chain
chain = ToolChain([extract_text, summarize_text, translate_text])
result = chain.execute("document.pdf")
```

### 2. Parallel Tool Execution

```python
import asyncio
from typing import List, Callable, Any

class ParallelToolExecutor:
    async def execute_parallel(self, tools: List[Callable], input_data: Any) -> List[Any]:
        """Execute multiple tools in parallel with the same input."""
        tasks = [self._safe_execute(tool, input_data) for tool in tools]
        results = await asyncio.gather(*tasks, return_exceptions=True)
        return results
    
    async def _safe_execute(self, tool: Callable, input_data: Any) -> Any:
        """Safely execute a tool and handle exceptions."""
        try:
            if asyncio.iscoroutinefunction(tool):
                return await tool(input_data)
            else:
                return tool(input_data)
        except Exception as e:
            return f"Error in {tool.__name__}: {str(e)}"

# Example usage
async def main():
    executor = ParallelToolExecutor()
    
    tools = [get_weather, get_news, get_stock_price]
    results = await executor.execute_parallel(tools, "New York")
    
    for i, result in enumerate(results):
        print(f"Tool {i+1} result: {result}")
```

---

## 📋 Tool Integration Checklist

### Before Integration
- [ ] Tool serves a clear, specific purpose
- [ ] Input/output formats are well-defined
- [ ] Error cases are handled gracefully
- [ ] Documentation is complete
- [ ] Security considerations are addressed

### During Integration
- [ ] Input validation is implemented
- [ ] Rate limiting is configured
- [ ] Logging is set up
- [ ] Error handling is comprehensive
- [ ] Performance monitoring is enabled

### After Integration
- [ ] Tool functionality is tested
- [ ] Error scenarios are tested
- [ ] Performance is acceptable
- [ ] Security review is completed
- [ ] Documentation is updated

### Ongoing Maintenance
- [ ] Monitor tool usage and performance
- [ ] Update API keys and credentials as needed
- [ ] Keep dependencies updated
- [ ] Review and improve error handling
- [ ] Optimize performance based on usage patterns

---

## 🏭 Real-World Production Tool Examples (February 2026)

### Example 1: Customer Service Agent (Intercom-style)
```python
from langchain_core.tools import tool
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
import requests

@tool
def search_crm(customer_email: str) -> dict:
    """Search CRM for customer information (Salesforce integration)."""
    # Real implementation: Salesforce API
    # Used by 95% of enterprise customer service agents
    headers = {"Authorization": f"Bearer {SALESFORCE_TOKEN}"}
    response = requests.get(
        f"https://your-domain.salesforce.com/services/data/v58.0/query/",
        params={"q": f"SELECT Id, Name, Email, AccountId FROM Contact WHERE Email = '{customer_email}'"},
        headers=headers
    )
    return response.json()

@tool
def get_order_history(customer_id: str) -> list:
    """Retrieve customer order history from database."""
    # Real implementation: Database query
    # Critical for e-commerce support agents
    conn = get_db_connection()
    orders = conn.execute(
        "SELECT order_id, date, total, status FROM orders WHERE customer_id = ? ORDER BY date DESC LIMIT 10",
        (customer_id,)
    ).fetchall()
    return [dict(order) for order in orders]

@tool
def create_support_ticket(issue: str, priority: str, customer_id: str) -> str:
    """Create support ticket in Zendesk/Jira."""
    # Real implementation: Zendesk API
    # Used for escalation in 50% of complex cases
    response = requests.post(
        "https://yourcompany.zendesk.com/api/v2/tickets.json",
        headers={"Authorization": f"Bearer {ZENDESK_TOKEN}"},
        json={
            "ticket": {
                "subject": issue,
                "priority": priority,
                "requester_id": customer_id,
                "comment": {"body": issue}
            }
        }
    )
    return f"Ticket created: {response.json()['ticket']['id']}"

@tool
def check_inventory(product_id: str) -> dict:
    """Check product inventory across warehouses."""
    # Real implementation: Inventory management system
    # Essential for e-commerce agents
    inventory = requests.get(
        f"https://api.inventory.com/v1/products/{product_id}/stock",
        headers={"Authorization": f"Bearer {INVENTORY_TOKEN}"}
    ).json()
    return {
        "product_id": product_id,
        "in_stock": inventory["quantity"] > 0,
        "quantity": inventory["quantity"],
        "warehouses": inventory["locations"]
    }

# Production customer service agent
llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
tools = [search_crm, get_order_history, create_support_ticket, check_inventory]
agent = create_react_agent(llm, tools)

# Real conversation example
def handle_customer_inquiry(message: str, customer_email: str):
    """
    Production-ready customer service.
    Used by: Shopify stores, SaaS companies
    Resolution rate: 50-60%
    Average handling time: 30 seconds
    """
    result = agent.invoke({
        "messages": [
            ("system", f"Customer email: {customer_email}"),
            ("user", message)
        ]
    })
    return result['messages'][-1].content

# Example query
response = handle_customer_inquiry(
    "My order #12345 hasn't arrived yet and I need it urgently",
    "customer@example.com"
)
# Agent will:
# 1. Search CRM for customer
# 2. Get order history
# 3. Check order status
# 4. Create escalation ticket if needed
# 5. Provide status update
```

### Example 2: Developer Agent (GitHub Copilot Workspace-style)
```python
import subprocess
from langchain_core.tools import tool

@tool
def read_file(file_path: str) -> str:
    """Read file contents from repository."""
    # Core tool used by all coding agents
    try:
        with open(file_path, 'r') as f:
            return f.read()
    except Exception as e:
        return f"Error reading file: {str(e)}"

@tool
def write_file(file_path: str, content: str) -> str:
    """Write content to file."""
    # Used for implementing code changes
    try:
        with open(file_path, 'w') as f:
            f.write(content)
        return f"Successfully wrote to {file_path}"
    except Exception as e:
        return f"Error writing file: {str(e)}"

@tool
def run_tests(test_path: str = "tests/") -> dict:
    """Run test suite and return results."""
    # Critical for validation in coding agents
    # Used by: Devin, Cursor, GitHub Copilot Workspace
    result = subprocess.run(
        ["pytest", test_path, "-v", "--tb=short"],
        capture_output=True,
        text=True,
        timeout=300
    )
    return {
        "success": result.returncode == 0,
        "stdout": result.stdout,
        "stderr": result.stderr,
        "tests_passed": result.stdout.count(" PASSED"),
        "tests_failed": result.stdout.count(" FAILED")
    }

@tool
def lint_code(file_path: str) -> dict:
    """Run linter on code file."""
    # Essential for code quality
    result = subprocess.run(
        ["pylint", file_path, "--output-format=json"],
        capture_output=True,
        text=True
    )
    import json
    issues = json.loads(result.stdout) if result.stdout else []
    return {
        "issues": issues,
        "error_count": len([i for i in issues if i['type'] == 'error']),
        "warning_count": len([i for i in issues if i['type'] == 'warning'])
    }

@tool
def git_diff() -> str:
    """Show current git diff."""
    # Used for reviewing changes before commit
    result = subprocess.run(
        ["git", "diff"],
        capture_output=True,
        text=True
    )
    return result.stdout

@tool
def search_codebase(pattern: str) -> list:
    """Search codebase for pattern using ripgrep."""
    # Essential for understanding code context
    # Used by: Cursor, GitHub Copilot Workspace
    result = subprocess.run(
        ["rg", pattern, "--json"],
        capture_output=True,
        text=True
    )
    matches = []
    for line in result.stdout.split('\n'):
        if line.strip():
            import json
            match = json.loads(line)
            if match.get('type') == 'match':
                matches.append({
                    "file": match['data']['path']['text'],
                    "line": match['data']['line_number'],
                    "text": match['data']['lines']['text']
                })
    return matches

# Coding agent with full toolset
coding_agent = create_react_agent(
    ChatOpenAI(model="gpt-4o"),
    [read_file, write_file, run_tests, lint_code, git_diff, search_codebase]
)

# Production metrics (GitHub Copilot Workspace):
# - Files modified per task: 3-7
# - Test success rate: 70%
# - Time per task: 5-15 minutes
# - Human review required: 80% of changes
```

### Example 3: Research Agent (Consensus.app-style)
```python
@tool
def search_arxiv(query: str, max_results: int = 10) -> list:
    """Search arXiv for research papers."""
    # Core tool for academic agents
    # Used by: Consensus, Elicit, SciSpace
    import arxiv
    
    search = arxiv.Search(
        query=query,
        max_results=max_results,
        sort_by=arxiv.SortCriterion.Relevance
    )
    
    papers = []
    for result in search.results():
        papers.append({
            "title": result.title,
            "authors": [author.name for author in result.authors],
            "summary": result.summary,
            "published": result.published.strftime("%Y-%m-%d"),
            "url": result.entry_id,
            "pdf_url": result.pdf_url
        })
    return papers

@tool
def extract_paper_claims(pdf_url: str) -> list:
    """Extract key claims from research paper."""
    # Advanced tool for paper analysis
    # Powers Consensus's claim extraction
    import PyPDF2
    import requests
    
    # Download PDF
    response = requests.get(pdf_url)
    pdf_file = PyPDF2.PdfReader(io.BytesIO(response.content))
    
    # Extract text
    full_text = ""
    for page in pdf_file.pages:
        full_text += page.extract_text()
    
    # Use LLM to extract claims
    llm = ChatOpenAI(model="gpt-4o")
    claims = llm.invoke([
        ("system", "Extract key scientific claims from this paper. List 3-5 main findings."),
        ("user", full_text[:4000])  # First 4000 chars
    ])
    
    return claims.content

@tool  
def search_citations(paper_id: str) -> dict:
    """Get citation count and influential citations."""
    # Used for impact assessment
    # Real API: Semantic Scholar
    response = requests.get(
        f"https://api.semanticscholar.org/v1/paper/{paper_id}",
        headers={"x-api-key": SEMANTIC_SCHOLAR_KEY}
    )
    data = response.json()
    return {
        "citation_count": data.get("citationCount", 0),
        "influential_citation_count": data.get("influentialCitationCount", 0),
        "year": data.get("year"),
        "venue": data.get("venue")
    }

# Production metrics (Consensus.app):
# - Papers analyzed per query: 50-200
# - Claim extraction accuracy: 89%
# - Response time: 10-30 seconds
# - Cost per query: $0.50-1.50
```

## 📊 Production Tool Performance (February 2026)

### Tool Reliability by Category
```
Search & Retrieval Tools:
- Success Rate: 98-99%
- Average Latency: 0.5-2s
- Cost per call: $0.001-0.01
- Examples: DuckDuckGo, Google Custom Search

Database & CRM Tools:
- Success Rate: 99.5-99.9%
- Average Latency: 0.1-0.5s
- Cost per call: Near zero (internal)
- Examples: Salesforce, PostgreSQL, MongoDB

API Integration Tools:
- Success Rate: 95-98% (depends on external API)
- Average Latency: 0.5-3s
- Cost per call: Varies by API
- Examples: Stripe, Twilio, SendGrid

Code Execution Tools:
- Success Rate: 90-95% (sandbox dependent)
- Average Latency: 1-10s
- Security: Requires sandboxing
- Examples: Python REPL, Shell, npm

File System Tools:
- Success Rate: 99%+
- Average Latency: <0.1s
- Security: Path validation required
- Examples: read_file, write_file
```

### Common Tool Integration Pitfalls

1. **Timeout Issues** (40% of problems)
   - Solution: Set appropriate timeouts (30-60s for most tools)
   - Example: Salesforce queries can take 5-10s

2. **Rate Limiting** (30% of problems)
   - Solution: Implement exponential backoff
   - Example: GitHub API: 5000 requests/hour

3. **Authentication Failures** (20% of problems)
   - Solution: Token refresh mechanisms
   - Example: OAuth tokens expire after 1 hour

4. **Data Validation** (10% of problems)
   - Solution: Validate inputs before API calls
   - Example: Email format, phone numbers

---


This guide provides a comprehensive foundation for integrating tools with AI agents across different frameworks. Remember to always prioritize security, performance, and user experience when designing and implementing tool integrations.