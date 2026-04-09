# BEI Agent

Shared [OpenCode](https://opencode.ai) agent definitions for the Backend Infrastructure (BEI) team.

Agents are specialized AI assistants with custom prompts, model settings, and tool permissions. This repo lets the team share and collaborate on agents via Git.

## Prerequisites

- [OpenCode](https://opencode.ai) installed
- Git

## Install

```bash
git clone git@github.com:<org>/bei-agent.git
cd bei-agent
./install.sh
```

This creates symlinks from `~/.config/opencode/agents/` to the agent files in this repo. OpenCode picks them up automatically on next launch.

## Update

Pull the latest changes. Symlinks mean new or modified agents are available immediately.

```bash
cd bei-agent
git pull
```

If new agent files were added, re-run the install script to create their symlinks:

```bash
./install.sh
```

## Uninstall

Removes only the symlinks created by this repo. Your own agents are left untouched.

```bash
./uninstall.sh
```

## Usage

Once installed, agents are available globally in OpenCode:

- **Primary agents** -- cycle with the `Tab` key
- **Subagents** -- invoke with `@agent-name` in your message

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add or modify agents.

## License

MIT
