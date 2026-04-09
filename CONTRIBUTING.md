# Contributing to BEI Agent

Thanks for contributing! Adding or improving agents and skills is straightforward.

---

## Agents

### How agents work

Each `.md` file in the `agents/` directory becomes an OpenCode agent. The filename (without `.md`) is the agent name. For example, `db-migrator.md` creates the `db-migrator` agent.

### Creating a new agent

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

### Agent file format

#### Required frontmatter fields

| Field         | Description                                      |
|---------------|--------------------------------------------------|
| `description` | Brief description shown in the agent list        |

#### Common optional fields

| Field         | Description                                      |
|---------------|--------------------------------------------------|
| `mode`        | `primary`, `subagent`, or `all` (default: `all`) |
| `model`       | Override the model (e.g. `anthropic/claude-sonnet-4-20250514`) |
| `temperature` | 0.0-1.0, controls response randomness            |
| `color`       | Hex color or theme color for the UI              |
| `permission`  | Tool permissions (`edit`, `bash`, `webfetch`)    |
| `hidden`      | `true` to hide from @ autocomplete               |

#### Body (after frontmatter)

The markdown body is the agent's system prompt. Write clear instructions for what the agent should do, how it should behave, and what to focus on.

### Naming conventions

- Lowercase, hyphen-separated: `db-migrator`, `security-auditor`
- Keep names short but descriptive
- Avoid generic names like `helper` or `tool`

---

## Skills

### How skills work

Each subdirectory in `skills/` is a skill. The directory must contain a `SKILL.md` file. The directory name is the skill name. For example, `skills/git-release/SKILL.md` creates the `git-release` skill.

Agents discover available skills automatically and load them on demand when they match the task at hand.

### Creating a new skill

1. Create a new branch:

   ```bash
   git checkout -b add-<skill-name>
   ```

2. Create the skill directory and `SKILL.md`:

   ```bash
   mkdir skills/<skill-name>
   touch skills/<skill-name>/SKILL.md
   ```

3. Use the following template for `SKILL.md`:

   ```markdown
   ---
   name: my-skill
   description: What this skill does and when to use it
   ---

   ## What I do

   - Capability 1
   - Capability 2

   ## When to use me

   Use this skill when [scenario]. Ask clarifying questions if [condition].

   ## Instructions

   1. Step 1
   2. Step 2
   3. Step 3
   ```

4. Optionally add supporting files:

   ```
   skills/<skill-name>/
   ├── SKILL.md           # Required
   ├── scripts/           # Optional helper scripts
   └── reference/         # Optional reference docs
   ```

5. Test locally -- after running `./install.sh`, the skill is symlinked and available. Ask an agent to use it or check that it appears in the skill list.

6. Commit and open a PR:

   ```bash
   git add skills/<skill-name>/
   git commit -m "feat: add <skill-name> skill"
   git push -u origin add-<skill-name>
   ```

### Skill file format

#### Required frontmatter fields

| Field         | Description                                               |
|---------------|-----------------------------------------------------------|
| `name`        | Must match the directory name, lowercase with hyphens     |
| `description` | 1-1024 chars, specific enough for agents to choose wisely |

#### Optional frontmatter fields

| Field           | Description                          |
|-----------------|--------------------------------------|
| `license`       | License identifier (e.g. `MIT`)      |
| `compatibility` | Platform compatibility               |
| `metadata`      | Key-value pairs for extra metadata   |

#### Name rules

- 1-64 characters
- Lowercase alphanumeric with single hyphen separators
- No leading/trailing hyphens, no consecutive hyphens (`--`)
- Must match the directory name

---

## General guidelines

- Keep prompts focused -- one agent/skill, one purpose
- Set restrictive permissions by default and loosen only when needed
- Test before submitting a PR
- Describe what you changed and why in the PR description

## Modifying existing agents or skills

1. Branch, edit the files, test locally, open a PR.
2. Describe what you changed and why in the PR description.

## Full reference

- [OpenCode Agents docs](https://opencode.ai/docs/agents/)
- [OpenCode Skills docs](https://opencode.ai/docs/skills/)
