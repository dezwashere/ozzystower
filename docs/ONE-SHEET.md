# OzzysTower: what it is and how to use it

OzzysTower is a reusable way to organize AI-assisted work on software projects. It is not an app that you install or compile. Think of it as a small playbook that tells Codex how to work with you, when to ask for help, how to check its work, and how to avoid spending extra time or money without a reason.

## What is included

Ozzy is the lead assistant. She handles simple tasks herself and can ask one of six specialists for focused help when that will make a real difference. The specialists have different jobs: building a change, testing it, investigating a problem, reviewing work, checking security, or thinking through architecture.

The instructions and settings live in `AGENTS.md` and the `.codex` folder. They set the default model, explain the specialists� roles, and describe safety and approval boundaries. The guides in `docs/orchestration` explain everyday use, low-usage habits, verification, and how to hand a small code sample to DeepSeek for an optional review.

There are also a few helper scripts. One prepares a limited set of files and instructions for a review, then saves the results and usage information. Another starts the existing DeepSeek review session. A small test script checks that this handoff works without contacting DeepSeek. The scripts use Python and PowerShell already available in the environment; OzzysTower does not need a separate install step.

## How to use OzzysTower with a project

Keep the app or other project in its own folder or repository. Start by opening that project and reading its own `AGENTS.md` or setup notes. Those instructions explain how the project works and what must be protected.

Then bring over the parts of OzzysTower that are useful: its Codex settings, specialist descriptions, working rules, and helper scripts. If the project already has instructions or settings, combine them carefully so its existing rules are not overwritten. Open a new trusted Codex session after changing project settings; the new defaults may not load into a session that is already running.

For everyday work, describe the task and let Ozzy inspect the relevant files. She can make an approved change and run the project�s existing checks. Most small tasks do not need a specialist. If a task needs a second opinion or special expertise, Ozzy can ask one specialist to focus on just that part.

## Reviews and safety

DeepSeek is an optional outside reviewer. It is a separate paid service, so each review requires your explicit approval. Before anything is sent, inspect the files and instructions in the review packet. The helper saves the response so Ozzy can check any findings against the actual code. It does not automatically retry a failed request or switch to another service.

OzzysTower�s settings apply to this project; they do not change your global Codex settings. They also do not replace the rules of the project you are working on. Follow that project�s instructions for code changes, tests, installs, builds, and publishing.

To get started, read `AGENTS.md`, then `docs/orchestration/OPERATING.md`. For the optional review workflow, see `docs/orchestration/HANDOFF.md`.
