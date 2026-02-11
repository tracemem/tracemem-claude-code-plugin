#!/bin/bash
# Inject TraceMem context at session start
# stdout from SessionStart hooks is added as context for Claude

if [ -z "$TRACEMEM_API_KEY" ]; then
  echo "[TraceMem] Warning: TRACEMEM_API_KEY is not set. Decision tracking is disabled."
  echo "[TraceMem] Set your API key with: export TRACEMEM_API_KEY=your_key_here"
  exit 0
fi

# Get git context if available
GIT_BRANCH=""
GIT_REPO=""
if command -v git &> /dev/null && git rev-parse --is-inside-work-tree &> /dev/null 2>&1; then
  GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
  GIT_REPO=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" || echo "unknown")
fi

cat <<EOF
[TraceMem] Decision tracking is active.
[TraceMem] Project: ${GIT_REPO:-unknown} | Branch: ${GIT_BRANCH:-unknown}
[TraceMem] Use /tracemem-open to start tracking a decision, or it will be opened automatically when significant work begins.
[TraceMem] Use /tracemem-record to record a one-shot architecture or engineering decision.
[TraceMem] All significant architectural decisions, technology choices, and trade-offs will be recorded.
EOF
