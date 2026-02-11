# TraceMem Plugin for Claude Code

Decision memory for Claude Code. Automatically tracks architectural decisions, code changes, and engineering choices into TraceMem's governed audit trail.

## Quickstart

### 1. Install the plugin

**From the marketplace:**

```
/plugin marketplace add tracemem/tracemem-claude-code-plugin
/plugin install tracemem
```

**From a local clone:**

```
/plugin install /path/to/tracemem-claude-code-plugin
```

### 2. Set your API key

```bash
# Add to ~/.bashrc, ~/.zshrc, or your shell profile
export TRACEMEM_API_KEY=your_api_key_here
```

Or in your project's `.env` file:

```
TRACEMEM_API_KEY=your_api_key_here
```

Get your API key from [app.tracemem.com](https://app.tracemem.com) under your project settings.

### 3. Verify setup

```
/tracemem-doctor
```

This checks your API key, MCP server connectivity, and available tools.

## Available Commands

| Command | Description |
|---------|-------------|
| `/tracemem-open [action]` | Open a decision envelope for the current task |
| `/tracemem-close [commit\|abort]` | Close the active decision envelope |
| `/tracemem-note <message>` | Add a note to the active decision |
| `/tracemem-status` | Show the active decision state |
| `/tracemem-trace [id]` | View the decision trace |
| `/tracemem-receipt [id]` | Get the immutable receipt for a closed decision |
| `/tracemem-record <description>` | Record a one-shot architecture/engineering decision |
| `/tracemem-search [query]` | Search past decisions for precedent |
| `/tracemem-doctor` | Verify plugin setup and connectivity |

### Actions for `/tracemem-open`

| Action | Intent | Use when |
|--------|--------|----------|
| `edit_files` | `code.change.apply` | General code editing (default) |
| `refactor` | `code.refactor.execute` | Restructuring code |
| `run_command` | `ops.command.execute` | Operational commands |
| `deploy` | `deploy.release.execute` | Deployments and releases |
| `secrets` | `secrets.change.propose` | Secret modifications |
| `db_change` | `data.change.apply` | Database changes |
| `review` | `code.review.assist` | Code review |

## How Automatic Tracking Works

The plugin uses three layers to ensure decisions are captured:

### Skills

The `decision-tracking` skill teaches Claude *when* and *how* to track decisions autonomously. When Claude detects significant technical choices (architecture, dependencies, schema changes, API modifications), it records them automatically.

### Hooks

Lifecycle hooks provide guaranteed automation:

- **Session Start**: Injects TraceMem context so Claude knows tracking is available
- **Post-Tool Use**: After file writes or bash commands, evaluates whether the change represents a significant decision
- **Stop**: Before finishing, reviews the session for missed decisions and auto-closes open envelopes
- **Session End**: Lightweight cleanup logging

### Agents

Two specialized agents handle decision workflows:

- **Decision Tracker**: Identifies and records key decisions during coding
- **Decision Reviewer**: Reviews the decision trace for completeness before closing

## Two Recording Paths

### One-shot recording (`/tracemem-record`)

For architecture and engineering decisions that don't require data product operations. This is the most common path during coding:

```
/tracemem-record Use Redis for session caching
```

Claude will search for existing decisions, gather details from context, and record the decision in a single operation.

### Full envelope (`/tracemem-open` ... `/tracemem-close`)

For decisions involving governed data reads/writes, policy evaluations, or approval workflows:

```
/tracemem-open edit_files
... work on the task ...
/tracemem-close
```

## Configuration

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `TRACEMEM_API_KEY` | **Yes** | API key for TraceMem authentication |
| `TRACEMEM_MCP_URL` | No | Override MCP server URL (default: `https://mcp.tracemem.com`) |

### MCP Server

The plugin connects to TraceMem's cloud-hosted MCP server via HTTP. No local process to manage. The connection is configured in `.mcp.json` and started automatically when the plugin is enabled.

## What Gets Tracked

**Always tracked:**
- Database schema changes and migrations
- New dependency additions
- API contract changes
- Infrastructure and deployment decisions
- Security-relevant choices
- Explicit trade-offs discussed with the user

**Never tracked:**
- Formatting, typo fixes, comment additions
- Routine test runs
- File navigation or code reading
- Clarifying questions

## Security

- API keys and credentials are never included in decision records
- File contents are summarized, not embedded raw
- TraceMem's MCP server applies server-side redaction
- Environment variable *names* are logged, but not their *values*

## Documentation

- [TraceMem Documentation](https://www.tracemem.com/docs)
- [Decision Envelopes](https://www.tracemem.com/docs/concepts/decision-envelopes)
- [Claude Code Integration Guide](https://www.tracemem.com/docs/guides/claude-code-integration)
- [API Reference](https://www.tracemem.com/docs/api/overview)

## License

Apache-2.0 — see [LICENSE](LICENSE) for details.
