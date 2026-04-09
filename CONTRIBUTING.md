# Contributing to BEI Agent

Thanks for contributing! Adding or improving an agent is straightforward.

## How agents work

Each `.md` file in the `agents/` directory becomes an OpenCode agent. The filename (without `.md`) is the agent name. For example, `db-migrator.md` creates the `db-migrator` agent.

## Creating a new agent

1. Create a new branch:

   ```bash
   git checkout -b add-<agent-name>
   ```

2. Create a new `.md` file in `agents/`:

   ```bash
   touch agents/<agent-name>.md
   ```

3. Use the following template:

   ```markdown
   ---
   description: Short description of what this agent does
   mode: subagent
   # model: anthropic/claude-sonnet-4-20250514   # optional, uses caller's model if omitted
   # temperature: 0.3                            # optional
   # color: "#FF5733"                            # optional
   permission:
     edit: deny
     bash: deny
   ---

   You are a [role]. Your purpose is to [what you do].

   Focus on:

   - Point 1
   - Point 2
   - Point 3
   ```

4. Test locally -- the symlink from `./install.sh` means your changes are live immediately. Open OpenCode and try `@<agent-name>`.

5. Commit and open a PR:

   ```bash
   git add agents/<agent-name>.md
   git commit -m "feat: add <agent-name> agent"
   git push -u origin add-<agent-name>
   ```

## Agent file format

### Required frontmatter fields

| Field         | Description                                      |
|---------------|--------------------------------------------------|
| `description` | Brief description shown in the agent list        |

### Common optional fields

| Field         | Description                                      |
|---------------|--------------------------------------------------|
| `mode`        | `primary`, `subagent`, or `all` (default: `all`) |
| `model`       | Override the model (e.g. `anthropic/claude-sonnet-4-20250514`) |
| `temperature` | 0.0-1.0, controls response randomness            |
| `color`       | Hex color or theme color for the UI              |
| `permission`  | Tool permissions (`edit`, `bash`, `webfetch`)    |
| `hidden`      | `true` to hide from @ autocomplete               |

### Body (after frontmatter)

The markdown body is the agent's system prompt. Write clear instructions for what the agent should do, how it should behave, and what to focus on.

## Naming conventions

- Lowercase, hyphen-separated: `db-migrator`, `security-auditor`
- Keep names short but descriptive
- Avoid generic names like `helper` or `tool`

## Modifying an existing agent

1. Branch, edit the `.md` file, test locally, open a PR.
2. Describe what you changed and why in the PR description.

## Guidelines

- Keep prompts focused -- one agent, one purpose
- Set restrictive permissions by default (`edit: deny`, `bash: deny`) and loosen only when needed
- Test your agent before submitting a PR
- Include examples of how to use the agent in the PR description

## Full reference

See the [OpenCode Agents docs](https://opencode.ai/docs/agents/) for all configuration options.
