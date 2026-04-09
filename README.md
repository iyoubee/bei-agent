# BEI Agent

Shared [OpenCode](https://opencode.ai) agents and skills for the Backend Infrastructure (BEI) team.

- **Agents** -- specialized AI assistants with custom prompts, model settings, and tool permissions.
- **Skills** -- reusable instructions that agents can load on demand for specific workflows.

This repo lets the team share and collaborate on both via Git.

## Prerequisites

- [OpenCode](https://opencode.ai) installed
- Git

## Install

```bash
git clone git@github.com:<org>/bei-agent.git
cd bei-agent
./install.sh
```

This creates symlinks from `~/.config/opencode/` to the agent and skill files in this repo. OpenCode picks them up automatically on next launch.

## Update

Pull the latest changes. Symlinks mean modified agents and skills are available immediately.

```bash
cd bei-agent
git pull
```

If new agents or skills were added, re-run the install script to create their symlinks:

```bash
./install.sh
```

## Uninstall

Removes only the symlinks created by this repo. Your own agents and skills are left untouched.

```bash
./uninstall.sh
```

## Usage

Once installed, everything is available globally in OpenCode:

- **Primary agents** -- cycle with the `Tab` key
- **Subagents** -- invoke with `@agent-name` in your message
- **Skills** -- agents discover and load them automatically, or you can ask an agent to use a specific skill

## Repo structure

```
bei-agent/
├── agents/                    # One .md file per agent
│   └── example-agent.md
├── skills/                    # One directory per skill
│   └── example-skill/
│       └── SKILL.md
├── install.sh
├── uninstall.sh
├── README.md
└── CONTRIBUTING.md
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add or modify agents and skills.

## License

MIT
