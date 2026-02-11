---
description: "Show the status of the active TraceMem decision"
allowed-tools:
  - mcp__tracemem__decision_get
---

# TraceMem Decision Status

Show the current state of the active TraceMem decision envelope.

## Instructions

1. If there is no active decision, inform the user and suggest using `/tracemem-open`.

2. Call `mcp__tracemem__decision_get` with the active decision ID.

3. Display:
   - Decision ID
   - Intent
   - Mode (autonomous/propose)
   - State (open/closed)
   - Number of trace events
   - Creation time and duration
