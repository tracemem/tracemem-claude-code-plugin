---
description: "View the decision trace for the active or specified decision"
argument-hint: "[decision_id]"
allowed-tools:
  - mcp__tracemem__decision_trace
---

# View TraceMem Decision Trace

Display the full trace of the active (or specified) decision.

## Instructions

1. Use the provided decision_id, or fall back to the active decision.

2. Call `mcp__tracemem__decision_trace` and display the trace events in a readable format:
   - Event type
   - Timestamp
   - Summary of each event
   - Any policy evaluations and their results
   - Any approval requests and their status
