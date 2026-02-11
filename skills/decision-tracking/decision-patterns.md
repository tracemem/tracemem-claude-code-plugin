# Decision Patterns Reference

Common patterns that indicate a trackable decision is being made, plus structured recording templates.

## Trigger signals

Watch for these patterns in the coding workflow:

### Explicit signals (always track)
- User says "let's use X instead of Y"
- User asks "should we go with X or Y?"
- Discussion of pros/cons between alternatives
- User says "I've decided to..."
- Choosing between multiple valid implementation approaches

### Implicit signals (track when significant)
- Adding a new `import` or dependency to package.json / go.mod / requirements.txt
- Creating a new database migration file
- Adding a new API route or modifying an existing one
- Creating a new service, module, or significant abstraction
- Choosing a data structure or algorithm for a performance-sensitive path
- Setting up authentication, authorization, or encryption
- Configuring cloud infrastructure or container orchestration

### Anti-patterns (do not track)
- Renaming a variable for clarity
- Fixing a linter warning
- Updating a comment
- Adding whitespace or formatting
- Running `git status` or `ls`
- Routine test execution

## Categories

Choose the most specific applicable category:

| Category | Use For | Examples |
|----------|---------|----------|
| `architecture` | System design, component structure, data flow | "Use event sourcing for order processing" |
| `dependency` | Library, framework, or tool choices | "Use Zod for runtime validation" |
| `schema` | Database schema, data model changes | "Add composite index on (user_id, created_at)" |
| `api_design` | API endpoint design, contract decisions | "Use cursor-based pagination for list endpoints" |
| `infra` | Infrastructure, deployment, hosting decisions | "Deploy to Fly.io with auto-scaling" |
| `tradeoff` | Engineering tradeoffs with clear pros/cons | "Favor read latency over write throughput" |
| `convention` | Coding standards, naming conventions | "Use snake_case for database columns" |
| `other` | Anything that doesn't fit above | Miscellaneous decisions |

## Structured recording templates

### For decision_add_context (within an envelope)

```json
{
  "kind": "decision",
  "category": "<category>",
  "summary": "One sentence: what was decided",
  "rationale": "1-3 sentences: why this choice",
  "alternatives_considered": ["Alternative A: rejected because...", "Alternative B: rejected because..."],
  "impact": "What this affects going forward",
  "reversibility": "<easily_reversible|reversible_with_effort|irreversible>",
  "files_affected": ["path/to/file1.go", "path/to/file2.go"]
}
```

### For decision_record (one-shot, no envelope needed)

| Field | Required | Description |
|-------|----------|-------------|
| `title` | yes | Specific, one-line summary — include the key technology or approach |
| `category` | yes | One of the categories listed above |
| `context` | yes | Problem description with constraints (not a conversation excerpt) |
| `decision` | yes | What was chosen, with specific implementation details |
| `rationale` | yes | Why this approach over others, referencing specific requirements |
| `alternatives_considered` | if applicable | Array of `{ "option": "...", "rejected_because": "..." }` — **highest-value field** |
| `tags` | recommended | Technology names (`postgresql`, `go`) and concern areas (`concurrency`, `security`) |
| `constraints` | recommended | Constraints that influenced the decision |
| `consequences` | recommended | Downstream effects |
| `supersedes` | if applicable | Decision ID of the decision being replaced |

## Writing tips

### Title
- Be specific: "Use worker pool pattern for concurrent processing" not "Concurrency decision"
- Include the key technology or approach

### Context
- Write as a problem description, not a conversation excerpt
- Include constraints and requirements
- A reader 6 months from now should understand the situation

### Rationale
- Explain *why* this approach over others
- Reference specific requirements or constraints

### Alternatives
- **This is the highest-value field.** When someone later questions the decision, documented alternatives prevent re-evaluating the same options.
- Include at least one alternative for non-trivial decisions
- Include why each was rejected

### Tags
- Use technology names: `postgresql`, `go`, `grpc`
- Use concern areas: `concurrency`, `security`, `performance`
- Use project names if applicable
