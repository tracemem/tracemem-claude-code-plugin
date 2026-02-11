# Changelog

All notable changes to the TraceMem Claude Code Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-02-11

### Added
- Plugin manifest (`.claude-plugin/plugin.json`) with TraceMem metadata
- MCP server configuration (`.mcp.json`) for remote HTTP transport to TraceMem
- 9 slash commands:
  - `/tracemem-open` — open a decision envelope
  - `/tracemem-close` — close the active decision
  - `/tracemem-note` — add a note to the active decision
  - `/tracemem-status` — show active decision state
  - `/tracemem-trace` — view the decision trace
  - `/tracemem-receipt` — get decision receipt
  - `/tracemem-record` — one-shot decision recording
  - `/tracemem-search` — search past decisions
  - `/tracemem-doctor` — verify setup and connectivity
- 2 agent definitions:
  - `decision-tracker` — identifies and records key decisions during coding
  - `decision-reviewer` — reviews trace completeness before closing
- Decision tracking skill with intent mapping and decision pattern references
- Lifecycle hooks:
  - `SessionStart` — inject TraceMem context
  - `Stop` — auto-close open decision envelopes
  - `PostToolUse` — detect decision-worthy file changes and commands
  - `SessionEnd` — diagnostic logging
- Environment check utility script
- README with quickstart, command reference, and configuration guide
