# OzzysTower

OzzysTower is an open-source set of instructions, settings, specialist roles, and helper scripts for organizing work with Codex. It is a reusable playbook, not a standalone app.

Ozzy is the lead assistant. She handles straightforward work herself and can ask one of six specialists for focused help. The project includes low-usage guidance, approval rules, verification procedures, and an optional DeepSeek review handoff.

## Tools used

- **Codex** for the lead assistant, project instructions, settings, and specialist roles.
- **Python** and **PowerShell** for local review and verification helpers.
- **Git** for version history and sharing the project.
- **DeepSeek Flash**, optionally, for a separate paid code review. It is not required to use OzzysTower.

## Use it with a project

1. Open your project and read its `AGENTS.md` or other project instructions first.
2. Copy or adapt the OzzysTower instructions, `.codex` settings, roles, and scripts that are useful to you. Keep your project's own instructions and configuration; combine settings carefully instead of replacing them wholesale.
3. Open a new trusted Codex session so it can load the project settings.
4. Give Ozzy a task. She will inspect relevant files, make authorized changes, and use the project's existing checks.

Start with the [one-page guide](docs/ONE-SHEET.md), [operating guide](docs/orchestration/OPERATING.md), and [project instructions](AGENTS.md). The optional paid review workflow is explained in [DeepSeek handoff](docs/orchestration/HANDOFF.md).

OzzysTower does not install an app or change global Codex settings. Each project keeps its own source code, decisions, backups, and history. Any external review requires approval for both the paid request and the data being shared.
