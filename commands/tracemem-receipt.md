---
description: "Get the immutable receipt for a closed decision"
argument-hint: "[decision_id]"
allowed-tools:
  - mcp__tracemem__decision_receipt
---

# TraceMem Decision Receipt

Retrieve the immutable receipt for a completed decision.

## Instructions

1. Use the provided decision_id, or fall back to the most recently closed decision.

2. Call `mcp__tracemem__decision_receipt` and display the receipt details.

3. Note: Receipts are only available for closed decisions. If the decision is still open, inform the user and suggest using `/tracemem-close` first.
