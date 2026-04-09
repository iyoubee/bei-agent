---
description: Pull latest BEI agents, skills, and commands
agent: build
---

Read the file at ~/.config/opencode/.bei-agent-path to find where the bei-agent repo is cloned.

If the file does not exist, tell the user that BEI agents are not installed and they need to install first. Stop here.

Otherwise, cd to that directory and run:

!`cat ~/.config/opencode/.bei-agent-path`

Then pull the latest changes and re-run the install script:

1. `git pull` in the repo directory
2. Run `./install.sh` in the repo directory

Report what changed.
