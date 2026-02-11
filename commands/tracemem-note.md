---
description: "Add a note to the active TraceMem decision"
argument-hint: "<message>"
allowed-tools:
  - mcp__tracemem__decision_add_context
---

# Add TraceMem Note

Add a note to the currently active TraceMem decision envelope.

## Instructions

1. Take the user's message and add it as context to the active decision.

2. Call `mcp__tracemem__decision_add_context` with:
   - `decision_id`: the active decision ID
   - `context`: `{ "kind": "note", "message": "<user's message>", "timestamp": "<current ISO timestamp>" }`

3. Confirm the note was added.

4. If there is no active decision, inform the user and suggest using `/tracemem-open` first.
