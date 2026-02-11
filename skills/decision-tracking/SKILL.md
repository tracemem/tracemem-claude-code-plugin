---
name: "decision-tracking"
description: "Teaches Claude when and how to track engineering decisions in TraceMem during coding sessions. Use this skill whenever working on a project with the TraceMem plugin enabled."
---

# Decision Tracking Skill

This skill governs how you interact with TraceMem to create durable, auditable records of engineering decisions during coding sessions.

## When to activate

Activate this skill whenever:
- The TraceMem MCP tools are available (check for `mcp__tracemem__*` tools)
- You are making changes that involve architectural choices, technology selection, or significant trade-offs
- The user explicitly asks you to track decisions

## Core rules

- **All governed operations require a Decision Envelope**: You cannot read/write data products, evaluate policies, or request approvals without first calling `mcp__tracemem__decision_create`.
- **Traces are immutable**: Everything recorded in TraceMem is append-only. Do not store secrets, credentials, or PII.
- **Close required**: A decision left open is a "zombie" decision. Always ensure `mcp__tracemem__decision_close` is called.
- **Show your logic**: When making choices, record *why* — not just *what*.

## Two recording paths

TraceMem provides two paths for recording decisions. Choose based on whether you need governed data operations.

### Path 1: One-shot recording (preferred for coding decisions)

Use `mcp__tracemem__decision_record` when the decision does NOT require data product reads/writes, policy evaluations, or approval workflows. This is the most common path during coding sessions.

**Always search first** to avoid duplicates:

```
mcp__tracemem__decision_search({
  query: "session caching approach",
  category: "architecture"
})
```

Then record:

```
mcp__tracemem__decision_record({
  title: "Use Redis for session caching instead of in-memory store",
  category: "architecture",
  context: "Need shared state across multiple API instances for user sessions...",
  decision: "Use Redis with 30-minute TTL for session data...",
  rationale: "Redis provides shared state across instances with sub-millisecond reads...",
  alternatives_considered: [
    { option: "In-memory with sticky sessions", rejected_because: "Prevents horizontal scaling" },
    { option: "PostgreSQL advisory locks", rejected_because: "Too much latency for session lookups" }
  ],
  tags: ["redis", "caching", "sessions"],
  consequences: "Adds Redis as an infrastructure dependency"
})
```

If superseding an existing decision, include the `supersedes` field with the old decision ID.

### Path 2: Full decision envelope (for governed data operations)

Use the envelope workflow when the decision involves data product reads, writes, policy evaluation, or approval flows.

```
// Step 1: Create envelope
mcp__tracemem__decision_create({
  intent: "code.change.apply",
  automation_mode: "autonomous",
  metadata: {
    project: "<detected project name>",
    branch: "<current git branch>",
    description: "<brief task description>"
  }
})
// → Returns: decision_id

// Step 2: Operate within the envelope
mcp__tracemem__decision_read({ decision_id, product, purpose, query })
mcp__tracemem__decision_write({ decision_id, product, purpose, operation, mutation })
mcp__tracemem__decision_evaluate({ decision_id, policy_id, inputs })
mcp__tracemem__decision_add_context({ decision_id, context, summary })

// Step 3: Close the envelope (REQUIRED)
mcp__tracemem__decision_close({
  decision_id,
  action: "commit",
  reason: "Implemented Redis session cache with failover"
})
```

**Intent mapping reference**: See `intent-mapping.md` in this skill directory.

## Core workflow for coding sessions

### 1. Session start — Open a decision envelope

At the beginning of substantive work (not for quick questions or trivial edits), open a decision envelope:

```
mcp__tracemem__decision_create({
  intent: "code.change.apply",
  automation_mode: "autonomous",
  metadata: {
    project: "<detected project name>",
    branch: "<current git branch>",
    description: "<brief task description>"
  }
})
```

### 2. During work — Record decisions as they happen

When you make a significant choice, immediately record it. Do not batch decisions for later — record them at the moment of decision.

**If an envelope is active**, use `mcp__tracemem__decision_add_context`:

```json
{
  "kind": "decision",
  "category": "architecture",
  "summary": "Using Redis for session caching instead of in-memory store",
  "rationale": "Need shared state across multiple API instances",
  "alternatives_considered": ["In-memory with sticky sessions", "PostgreSQL advisory locks"],
  "reversibility": "easily_reversible"
}
```

**If no envelope is active**, use the one-shot `mcp__tracemem__decision_record` (search first).

**Decision categories and patterns**: See `decision-patterns.md` in this skill directory.

### 3. Adding context and notes

Use `mcp__tracemem__decision_add_context` to show your reasoning:

- **Add context as you go** — don't wait until the end
- **Log reasoning, not actions** — the trace already captures reads/writes
- Use `summary` for human-readable text, `payload` for machine-readable data
- Keep summaries concise: "Selected approach B due to latency requirements" not multi-paragraph essays

### 4. Policy evaluation — Check before sensitive actions

For actions that may have policy constraints (deployments, secret changes, data mutations):

```
mcp__tracemem__decision_evaluate({
  decision_id: "<active decision>",
  policy_id: "policy_name",
  inputs: { ... }
})
```

If a policy requires approval, use `mcp__tracemem__decision_request_approval` and wait.

### 5. Session end — Close the envelope

Before finishing, close the decision with a summary:

```
mcp__tracemem__decision_close({
  decision_id: "<active decision>",
  action: "commit",
  reason: "Implemented Redis session cache with failover to PostgreSQL"
})
```

## State management

Maintain the active decision ID in your working memory for the duration of the session. If the user switches tasks significantly (e.g., moves to a completely different feature), close the current decision and open a new one.

## What to track vs. ignore

**Always track:**
- Database schema changes (new tables, columns, indexes, migrations)
- New dependency additions (libraries, services, APIs)
- API contract changes (new endpoints, modified payloads, breaking changes)
- Infrastructure choices (hosting, scaling, caching, queuing)
- Security-relevant decisions (auth, encryption, access control)
- Explicit trade-offs discussed with the user

**Never track:**
- Formatting changes, typo fixes, comment additions
- Routine test runs
- File navigation or code reading
- Asking the user clarifying questions

**Judgment calls** — use your discretion for:
- Refactors that change internal structure but not behavior
- Configuration changes
- Build/CI modifications

## Error handling

- **Fail closed**: If something goes wrong, close the decision with `action: "abort"`.
- **Zombie prevention**: Always close decisions, even on errors. Don't leave them open.
- **Network errors on reads**: Safe to retry.
- **Network errors on writes**: Only safe to retry if you provided an `idempotency_key`.
- **Policy denials**: Do not retry — they are permanent for that context unless inputs change.

## Security and redaction

- **Never include** actual values of API keys, passwords, tokens, or credentials in decision context
- **Do include** the *names* of environment variables (e.g., "configured `REDIS_URL`" but not the actual URL value)
- **Do include** file paths, function names, class names, and configuration keys
- **Do NOT include** raw file contents — summarize what changed instead
- **Assume visibility**: Context strings are often visible in dashboards. Assume your manager can read them.
