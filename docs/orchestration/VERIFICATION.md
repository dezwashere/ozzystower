# Verification

Run checks from the repository root. Match each check to the files changed, and report failures or skipped checks clearly.

## Local checks

- Parse `.codex/config.toml` and every role file in `.codex/agents/` as TOML.
- Run the offline handoff tests with `python -m unittest discover -s scripts -p "test_*.py"`. These use mocks and do not contact DeepSeek.
- Parse the PowerShell launcher without invoking it.
- Confirm an unapproved review attempt is rejected before any provider call.
- Run `git diff --check` to catch whitespace errors.

## Limits

Offline checks do not prove a provider is currently available, confirm paid-review behavior end to end, or establish that Codex automatically discovers specialist role files in every environment. A live paid review requires separate explicit approval for both the cost and the selected data transfer. Do not run one just to validate a documentation or configuration change.

Project code and tests belong to the target project. Read its instructions first and use the checks it defines.
