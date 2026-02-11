---
description: "Record an architecture or engineering decision in one shot"
argument-hint: "<brief description of the decision>"
allowed-tools:
  - mcp__tracemem__decision_search
  - mcp__tracemem__decision_record
---

# Record TraceMem Decision

Record an architecture or engineering decision in a single operation, without needing a full decision envelope.

Use this for decisions that do NOT require data product operations (reads, writes, policy evaluations, or approvals). For decisions involving governed data access, use `/tracemem-open` instead.

## Instructions

1. **Search first** — Always check for existing related decisions before recording:
   - Call `mcp__tracemem__decision_search` with a query derived from the user's description
   - If similar decisions exist, inform the user and ask whether to:
     - **Supersede**: Record a new decision that supersedes the existing one
     - **Skip**: The existing decision is still valid, no new record needed
     - **Proceed**: Record as a new, independent decision

2. **Gather decision details** from the user's input and current context:
   - `title`: Specific, one-line summary (e.g., "Use Redis for session caching instead of in-memory store")
   - `category`: One of `architecture`, `dependency`, `schema`, `api_design`, `infra`, `tradeoff`, `convention`, `other`
   - `context`: Problem description with constraints and requirements (not a conversation excerpt)
   - `decision`: What was chosen, with implementation details
   - `rationale`: Why this approach was chosen over others

3. **Record the decision** by calling `mcp__tracemem__decision_record` with:
   - `title`: the decision title
   - `category`: the chosen category
   - `context`: the problem context
   - `decision`: what was decided
   - `rationale`: the reasoning
   - `alternatives_considered`: (if applicable) array of `{ "option": "...", "rejected_because": "..." }`
   - `tags`: relevant technology and topic tags (e.g., `["redis", "caching", "sessions"]`)
   - `constraints`: any constraints that influenced the decision
   - `consequences`: downstream effects of this decision
   - `supersedes`: (if superseding) the decision_id of the decision being replaced

4. **Confirm** to the user: show the decision ID, title, category, and any supersession link.

## Tips for Good Decisions

- **Title**: Be specific — "Use worker pool pattern for concurrent processing" not "Concurrency decision"
- **Context**: Write as a problem description a reader 6 months from now would understand
- **Alternatives**: This is the highest-value field — it prevents re-evaluating the same options later
- **Tags**: Use technology names (`postgresql`, `go`) and concern areas (`concurrency`, `security`)
