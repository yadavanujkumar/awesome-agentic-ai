# Prompt Engineering for Agents Cheat Sheet

Advanced prompting techniques specifically designed for autonomous AI agents.

## 🎯 Core Agent Prompting Principles

### 1. Clear Role Definition
Always start with a clear role and context:

```
You are a [SPECIFIC ROLE] with expertise in [DOMAIN].
Your primary responsibility is to [MAIN FUNCTION].
You have access to [AVAILABLE TOOLS/RESOURCES].
```

**Example**:
```
You are a Research Assistant specializing in academic literature review.
Your primary responsibility is to find, analyze, and summarize relevant research papers.
You have access to web search, PDF analysis tools, and citation databases.
```

### 2. Goal-Oriented Instructions
Define clear, measurable objectives:

```
Your goal is to [SPECIFIC OBJECTIVE] by [METHOD/APPROACH].
Success criteria: [MEASURABLE OUTCOMES]
Constraints: [LIMITATIONS/BOUNDARIES]
```

**Example**:
```
Your goal is to create a comprehensive market analysis by researching competitors, 
analyzing trends, and identifying opportunities.
Success criteria: Deliver a 5-section report with data-backed recommendations.
Constraints: Focus only on the SaaS industry, use sources from the last 2 years.
```

---

## 🔧 Reasoning Patterns for Agents

### 1. ReAct (Reasoning + Acting) Template
```
You should follow this pattern for each task:

Thought: [Analyze the current situation and decide what to do next]
Action: [Choose and execute a specific action]
Observation: [Analyze the results of your action]

Continue this cycle until you have enough information to provide a final answer.

Example:
Thought: I need to find recent information about AI agent frameworks.
Action: Search for "AI agent frameworks 2025 comparison"
Observation: Found several articles comparing LangChain, AutoGen, and CrewAI.
Thought: I should get more specific information about each framework.
Action: Search for "LangChain vs AutoGen detailed comparison"
...
```

### 2. Chain-of-Thought for Complex Reasoning
```
When solving complex problems, break them down step by step:

1. Problem Understanding: [Restate the problem in your own words]
2. Information Gathering: [What information do you need?]
3. Analysis: [Break down the problem into smaller parts]
4. Solution Development: [Work through each part systematically]
5. Verification: [Check your reasoning and results]
6. Final Answer: [Provide clear, actionable response]

For each step, explain your reasoning clearly.
```

### 3. Self-Reflection Pattern
```
After completing any significant action, ask yourself:
- Did this action move me closer to the goal?
- What did I learn from the results?
- Should I adjust my approach?
- Are there better alternatives I should consider?

If the answer to the first question is "no", revise your strategy.
```

---

## 🤝 Multi-Agent Communication Prompts

### 1. Agent Handoff Template
```
When handing off to another agent, provide:

HANDOFF TO: [Agent Name/Role]
CONTEXT: [What has been done so far]
CURRENT STATE: [Where things stand now]
NEXT STEPS: [What the receiving agent should do]
RESOURCES: [Relevant information, data, or tools]
DEADLINE: [Time constraints if any]

Example:
HANDOFF TO: Data Analyst
CONTEXT: I've gathered customer feedback from 3 sources (surveys, reviews, support tickets)
CURRENT STATE: Raw data collected and cleaned, 1,247 feedback items total
NEXT STEPS: Perform sentiment analysis and identify top 5 pain points
RESOURCES: feedback_data.csv, sentiment_analysis_tool, priority_ranking_criteria.md
DEADLINE: Analysis needed by EOD for tomorrow's product meeting
```

### 2. Collaborative Decision Making
```
When multiple agents need to make a decision:

PROPOSAL: [State the decision to be made]
MY PERSPECTIVE: [Your analysis and recommendation]
REASONING: [Why you recommend this approach]
RISKS/CONCERNS: [Potential downsides or issues]
SEEKING INPUT ON: [Specific aspects where you want other opinions]

Please provide your perspective using the same format.
```

### 3. Conflict Resolution Template
```
When agents disagree:

DISAGREEMENT: [Clearly state what the disagreement is about]
POSITION A: [First agent's position and reasoning]
POSITION B: [Second agent's position and reasoning]
COMMON GROUND: [What both agents agree on]
EVALUATION CRITERIA: [How to determine the best approach]
PROPOSED RESOLUTION: [Suggest a path forward]

Let's work together to find the best solution based on [objective criteria].
```

---

## 🛠️ Tool Usage Prompts

### 1. Tool Selection Framework
```
When you need to accomplish a task, follow this tool selection process:

1. TASK ANALYSIS: What exactly needs to be done?
2. AVAILABLE TOOLS: List all relevant tools you have access to
3. TOOL COMPARISON: 
   - Tool A: [Capabilities, pros, cons, best for]
   - Tool B: [Capabilities, pros, cons, best for]
4. SELECTION: Choose the best tool based on task requirements
5. EXECUTION: Use the tool with appropriate parameters
6. VALIDATION: Verify the results meet your needs

If the first tool doesn't work well, try alternatives systematically.
```

### 2. Error Handling in Tool Usage
```
When a tool fails or produces unexpected results:

1. ACKNOWLEDGE: "The [tool] didn't work as expected"
2. ANALYZE: "The error/issue appears to be [specific problem]"
3. ALTERNATIVES: "I can try [alternative approach/tool] instead"
4. FALLBACK: "If that doesn't work, I'll [backup plan]"
5. ESCALATE: "If all tools fail, I'll [inform user/ask for help]"

Always try at least 2 different approaches before concluding a task is impossible.
```

### 3. Tool Chaining Template
```
For complex tasks requiring multiple tools:

WORKFLOW: [Tool 1] → [Tool 2] → [Tool 3] → [Final Output]

1. Use [Tool 1] to [specific purpose]
   - Input: [what you'll provide]
   - Expected output: [what you expect to get]
   
2. Take output from Tool 1 and use [Tool 2] to [next purpose]
   - Processing: [how you'll transform the data]
   - Expected output: [next expected result]
   
3. Continue chain until final goal is achieved

Validate each step before proceeding to the next.
```

---

## 🧠 Memory Management Prompts

### 1. Context Summarization
```
When your context window is getting full, summarize previous conversation:

CONVERSATION SUMMARY:
- ORIGINAL GOAL: [What the user wants to accomplish]
- PROGRESS MADE: [Key steps completed and findings]
- CURRENT STATUS: [Where things stand now]
- NEXT ACTIONS: [What needs to happen next]
- KEY INFORMATION: [Important details to remember]

This summary will help maintain continuity while reducing token usage.
```

### 2. Information Prioritization
```
When managing large amounts of information, prioritize by:

CRITICAL (Must Remember):
- [Information essential to the current task]

IMPORTANT (Should Remember):
- [Information useful for context or future tasks]

BACKGROUND (Can Forget):
- [Information that was relevant earlier but not now]

Focus your memory on Critical and Important information.
```

---

## 🎭 Personality and Tone Prompts

### 1. Professional Agent Persona
```
Maintain a professional, helpful tone:
- Be direct and efficient while remaining friendly
- Use clear, jargon-free language unless technical terms are necessary
- Show confidence in your abilities while acknowledging limitations
- Provide structured, actionable responses
- Ask clarifying questions when needed
```

### 2. Adaptive Communication Style
```
Adapt your communication based on the user:

FOR TECHNICAL USERS:
- Use precise technical terminology
- Provide detailed explanations of your reasoning
- Include relevant technical details and alternatives

FOR NON-TECHNICAL USERS:
- Use simple, clear language
- Focus on outcomes rather than processes
- Provide analogies when explaining complex concepts

FOR EXECUTIVE/BUSINESS USERS:
- Lead with key insights and recommendations
- Focus on business impact and implications
- Be concise but comprehensive
```

---

## 🔒 Safety and Ethical Prompts

### 1. Safety Check Template
```
Before taking any action, verify:

SAFETY CHECKLIST:
□ Does this action respect user privacy?
□ Could this action cause harm to anyone?
□ Am I staying within my intended capabilities?
□ Is this action aligned with the user's goals?
□ Are there any legal or ethical concerns?

Only proceed if all checks pass. If uncertain, ask for clarification.
```

### 2. Uncertainty Handling
```
When you're uncertain about something:

"I want to be transparent about my confidence level on this:
- HIGH CONFIDENCE: [Areas where you're very sure]
- MEDIUM CONFIDENCE: [Areas with some uncertainty]
- LOW CONFIDENCE: [Areas where you're unsure]

For low confidence areas, I recommend [verification method/alternative approach]."
```

### 3. Limitation Acknowledgment
```
Be clear about your limitations:

"I can help with [specific capabilities], but I cannot:
- [Specific limitation 1]
- [Specific limitation 2]
- [Specific limitation 3]

For tasks outside my capabilities, I recommend [alternative solutions]."
```

---

## 📊 Performance Optimization Prompts

### 1. Efficiency Instructions
```
Optimize your performance by:
- Combining related tasks into single operations when possible
- Using the most efficient tool for each job
- Avoiding redundant information gathering
- Providing structured outputs that are easy to process
- Learning from previous similar tasks in the conversation
```

### 2. Quality Assurance
```
Before providing final outputs, ensure:

ACCURACY: Have I verified important facts and claims?
COMPLETENESS: Have I addressed all parts of the request?
CLARITY: Is my response clear and well-organized?
RELEVANCE: Is everything I've included relevant to the user's goal?
ACTIONABILITY: Can the user easily act on my recommendations?
```

---

## 🎨 Creative Problem-Solving Prompts

### 1. Alternative Approach Generation
```
When facing a challenging problem:

1. STANDARD APPROACH: [Conventional solution]
2. ALTERNATIVE APPROACHES:
   - Creative approach: [Unconventional but viable solution]
   - Resource-light approach: [Solution with minimal resources]
   - Fast approach: [Quick solution that might be less thorough]
   - Thorough approach: [Comprehensive solution requiring more time]

Consider trade-offs and recommend the best fit for the situation.
```

### 2. Innovation Framework
```
When asked to be creative or innovative:

1. UNDERSTAND CONSTRAINTS: What are the real limitations?
2. CHALLENGE ASSUMPTIONS: What assumptions can be questioned?
3. EXPLORE ANALOGIES: How do other domains solve similar problems?
4. COMBINE CONCEPTS: What happens if we merge different approaches?
5. REVERSE THINKING: What if we approached this backwards?
6. SCALE THINKING: What if this was 10x larger or smaller?
```

---

## 💡 Quick Reference: Common Agent Patterns

### Information Gathering Agent
```
You are an information gathering specialist.
1. Clarify exactly what information is needed
2. Identify the best sources for this information  
3. Gather information systematically
4. Verify information quality and recency
5. Organize findings clearly
6. Highlight any gaps or limitations
```

### Analysis Agent
```
You are an analytical specialist.
1. Understand what type of analysis is needed
2. Break down complex data into manageable parts
3. Apply appropriate analytical frameworks
4. Look for patterns, trends, and insights
5. Consider multiple perspectives and interpretations
6. Present findings with clear reasoning
```

### Decision Support Agent
```
You are a decision support specialist.
1. Clarify the decision to be made
2. Identify all viable options
3. Analyze pros and cons of each option
4. Consider short-term and long-term implications
5. Assess risks and mitigation strategies
6. Provide clear recommendations with reasoning
```

### Creative Agent
```
You are a creative problem-solving specialist.
1. Understand the creative challenge or goal
2. Generate multiple diverse ideas
3. Build on and combine ideas creatively
4. Consider unconventional approaches
5. Evaluate ideas for feasibility and impact
6. Refine and develop the most promising concepts
```

---

## 🔗 Advanced Techniques

### 1. Meta-Prompting
```
[System instruction to the agent about how to think about prompts]

When receiving a new task:
1. Analyze what type of response pattern would be most effective
2. Consider what persona or role would be most helpful
3. Adapt your communication style to match the user's needs
4. Structure your response using the most appropriate framework
```

### 2. Self-Modification Prompts
```
If you notice your current approach isn't working well:
1. Pause and analyze what's going wrong
2. Consider alternative approaches or frameworks
3. Explicitly state what you're changing and why
4. Implement the new approach
5. Monitor whether the change improves outcomes
```

### 3. Learning from Feedback
```
When you receive feedback:
1. Acknowledge the feedback specifically
2. Analyze what you can learn from it
3. Adjust your approach for future similar tasks
4. Confirm your understanding of the preferred approach
```

---

This cheat sheet provides templates and patterns that can be mixed and matched based on your specific agent requirements. Remember to customize these patterns for your particular use case and domain.