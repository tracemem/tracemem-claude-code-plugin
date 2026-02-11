---
description: "Close the active TraceMem decision envelope"
argument-hint: "[commit|abort] [reason]"
allowed-tools:
  - mcp__tracemem__decision_close
  - mcp__tracemem__decision_trace
  - mcp__tracemem__decision_add_context
---

# Close TraceMem Decision

Close the active TraceMem decision envelope.

## Instructions

1. Default action is `commit`. Use `abort` only if the user explicitly requests it or if the task failed.

2. Generate a concise reason summarizing what was accomplished (or why it was aborted).

3. Before closing, review the decision trace to ensure all significant decisions were captured. If important context is missing, add it via `mcp__tracemem__decision_add_context` before closing.

4. Call `mcp__tracemem__decision_close` with:
   - `decision_id`: the active decision ID
   - `action`: "commit" or "abort"
   - `reason`: the summary reason

5. Show the user a brief summary: decision ID, action taken, and trace event count.
