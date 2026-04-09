---
description: Remove all BEI agents, skills, and commands
agent: build
---

Read the file at ~/.config/opencode/.bei-agent-path to find where the bei-agent repo is cloned.

If the file does not exist, tell the user that BEI agents are not installed. Stop here.

Otherwise, run the uninstall script at that path:

!`cat ~/.config/opencode/.bei-agent-path`

Run `./uninstall.sh` in the repo directory.

After uninstalling, ask the user if they also want to delete the cloned repo directory.
