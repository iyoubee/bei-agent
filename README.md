# BEI Agent

Shared [OpenCode](https://opencode.ai) agents, skills, and commands for the Backend Infrastructure (BEI) team.

- **Agents** -- specialized AI assistants with custom prompts, model settings, and tool permissions.
- **Skills** -- reusable instructions that agents can load on demand for specific workflows.
- **Commands** -- slash commands for common team operations.

This repo lets the team share and collaborate on all of the above via Git.

## Prerequisites

- [OpenCode](https://opencode.ai) installed
- Git

## Install

Open OpenCode and paste this prompt:

> Clone the bei-agent repo from `git@github.com:traveloka/bei-agent.git` to a location of your choice and run `./install.sh` inside it to install the shared BEI agents, skills, and commands.

OpenCode will clone the repo and run the install script for you. That's it.

<details>
<summary>Manual install</summary>

```bash
git clone git@github.com:traveloka/bei-agent.git ~/bei-agent
cd ~/bei-agent
./install.sh
```

</details>

The install script:

1. Symlinks agents, skills, and commands to `~/.config/opencode/`
2. Writes a marker file at `~/.config/opencode/.bei-agent-path` so commands know where the repo lives

## Update

After install, use the built-in command:

```
/bei-update
```

This pulls the latest changes and re-runs the install script to pick up any new agents, skills, or commands.

## Uninstall

```
/bei-uninstall
```

Removes only the symlinks created by this repo. Your own agents, skills, and commands are left untouched.

## Usage

Once installed, everything is available globally in OpenCode:

- **Primary agents** -- cycle with the `Tab` key
- **Subagents** -- invoke with `@agent-name` in your message
- **Skills** -- agents discover and load them automatically, or you can ask an agent to use a specific skill
- **Commands** -- type `/bei-update` or `/bei-uninstall` in the TUI

## Repo structure

```
bei-agent/
├── agents/                    # One .md file per agent
│   └── example-agent.md
├── skills/                    # One directory per skill
│   └── example-skill/
│       └── SKILL.md
├── commands/                  # One .md file per command
│   ├── bei-update.md
│   └── bei-uninstall.md
├── install.sh
├── uninstall.sh
├── README.md
└── CONTRIBUTING.md
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add or modify agents, skills, and commands.

## License

MIT
