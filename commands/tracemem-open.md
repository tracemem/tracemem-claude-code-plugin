---
description: "Open a new TraceMem decision envelope for the current task"
argument-hint: "[action: edit_files|refactor|run_command|deploy|secrets|db_change|review]"
allowed-tools:
  - mcp__tracemem__decision_create
  - mcp__tracemem__capabilities_get
---

# Open TraceMem Decision

Open a new TraceMem decision envelope to begin tracking a coding task.

## Instructions

1. If the user provided an action argument, use it. Otherwise, infer the most appropriate action from the current context:
   - `edit_files` → intent `code.change.apply` (default for general coding)
   - `refactor` → intent `code.refactor.execute`
   - `run_command` → intent `ops.command.execute`
   - `deploy` → intent `deploy.release.execute`
   - `secrets` → intent `secrets.change.propose`
   - `db_change` → intent `data.change.apply`
   - `review` → intent `code.review.assist`

2. Call `mcp__tracemem__decision_create` with:
   - `intent`: the mapped intent string
   - `automation_mode`: "autonomous" (unless the action is `secrets` or `deploy`, use "propose")
   - `metadata`: include the current working directory, git branch (if available), and a brief description of the task

3. Store the returned `decision_id` — use it for all subsequent TraceMem operations in this session.

4. Confirm to the user: show the decision ID, intent, and mode.
