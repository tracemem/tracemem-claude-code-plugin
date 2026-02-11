# Intent Mapping Reference

Map coding actions to TraceMem decision intents.

## Action to intent mapping

| Action | Intent | When to use |
|--------|--------|-------------|
| `edit_files` | `code.change.apply` | General code editing, feature implementation |
| `refactor` | `code.refactor.execute` | Restructuring code without changing behavior |
| `run_command` | `ops.command.execute` | Running operational commands, scripts |
| `deploy` | `deploy.release.execute` | Deployment, release, or publishing |
| `secrets` | `secrets.change.propose` | Modifying secrets, API keys, credentials |
| `db_change` | `data.change.apply` | Database schema changes, migrations |
| `review` | `code.review.assist` | Code review, PR review |
| `test` | `code.test.execute` | Writing or running tests as primary task |
| `debug` | `code.debug.investigate` | Debugging, troubleshooting issues |
| `config` | `ops.config.change` | Infrastructure or build configuration |
| `docs` | `docs.update.apply` | Documentation as primary task |

## Custom intents

For domain-specific actions, use the hierarchical pattern `domain.entity.action`:

- `customer.onboarding.verification`
- `order.status.update`
- `invoice.payment.process`

## Automation mode selection

| Mode | When to use |
|------|-------------|
| `autonomous` | Default for most coding tasks. Agent proceeds without requiring approval. |
| `propose` | Use for sensitive operations — deployments, secret changes, data mutations affecting production. |
| `approve` | Use when the task requires explicit human sign-off before any action (rare in coding context). |
| `override` | Use only when explicitly instructed to bypass a previously denied policy (requires justification). |

### Mode selection rules

- Default to `autonomous` for general coding work
- Use `propose` when the action is `secrets` or `deploy`
- Use `propose` for production data mutations
- Use `approve` only if the user explicitly requests human-in-the-loop
- Never use `override` unless the user explicitly requests it and provides justification
