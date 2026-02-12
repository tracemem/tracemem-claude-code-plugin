# Contributing to TraceMem Claude Code Plugin

Thank you for your interest in contributing to TraceMem! This document provides guidelines for contributing to the TraceMem plugin for Claude Code.

## How to Contribute

### Reporting Issues

- Use [GitHub Issues](https://github.com/tracemem/tracemem-claude-code-plugin/issues) to report bugs or suggest features.
- Include steps to reproduce for bug reports.
- Include your Claude Code version and OS when reporting issues.

### Submitting Changes

1. Fork the repository.
2. Create a feature branch from `main` (`git checkout -b feature/my-improvement`).
3. Make your changes.
4. Test the plugin locally:
   ```
   /plugin install /path/to/your/fork
   /tracemem-doctor
   ```
5. Commit your changes with a clear message.
6. Push to your fork and submit a pull request.

### What You Can Contribute

- **Commands**: New slash commands in `commands/` (Markdown files).
- **Skills**: Improvements to decision tracking intelligence in `skills/`.
- **Hooks**: Enhanced automation triggers in `hooks/`.
- **Agents**: Specialized agents in `agents/`.
- **Documentation**: README, CHANGELOG, and inline documentation improvements.
- **Bug fixes**: Corrections to existing functionality.

### Code Style

- Commands and skills are Markdown files. Keep them clear and well-structured.
- Hook scripts should be POSIX-compatible bash (use `#!/bin/bash` and `set -euo pipefail` where appropriate).
- JSON files should be formatted with 2-space indentation.
- Agent and skill descriptions should be actionable and specific.

### Testing

Before submitting a PR, verify:

1. `/tracemem-doctor` passes with a valid API key.
2. All existing commands still work.
3. Hooks fire correctly (use `claude --debug` to verify).
4. New commands follow the naming convention: `tracemem-<action>.md`.

## Plugin Structure

```
tracemem-claude-code-plugin/
├── .claude-plugin/       # Plugin manifest and marketplace config
│   ├── plugin.json
│   └── marketplace.json
├── commands/             # Slash commands (/tracemem-*)
├── agents/               # Specialized agents
├── skills/               # Decision tracking skill
├── hooks/                # Lifecycle hooks
│   ├── hooks.json
│   └── scripts/
├── scripts/              # Utility scripts
├── SKILL.md              # Root-level skill (TraceMem overview)
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
└── LICENSE
```

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE).

## Questions?

- [TraceMem Documentation](https://www.tracemem.com/docs)
- [GitHub Discussions](https://github.com/tracemem/tracemem-claude-code-plugin/discussions)
