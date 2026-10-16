Current policy (October14): DeepSeek Flash remains an available independent reviewer with the verified automatic handoff, read-only execution, approval gate and usage capture intact. It can replace an additional Codex reviewer after explicit paid-use approval. Extra Codex review is risk-based, not mandatory. See LOW-USAGE.md for evidence/cost estimates; historical statuses below are retained.

# DeepSeek integration status

Verified on October 14, 2026 from official documentation:
- DeepSeek V4.1 Flash is currently exposed as `deepseek-flash`.
- DeepSeek documents native Responses API support and Codex setup using base_url `https://api.deepseek.com/` and wire_api `responses`.
- This is a moving model alias, not an immutable V4.1 version pin. Recheck the official release mapping before each activation; stop if it no longer resolves to V4.1 Flash. Never substitute another model silently.
- Codex supports custom providers at the session level and per-agent models. Custom agents inherit the parent's provider, permissions, and MCP servers. A role-level model_provider override does not enable native mixed-provider delegation.
- The current desktop spawn tool's allowed models do not include DeepSeek.

No DeepSeek request was made. No credential was requested, read, or written. No DeepSeek provider was activated in .codex/config.toml.

## Practical alternative (requires approval before activation)
Keep the lead and native specialists on the signed-in Codex provider. After user approval of paid usage and the specific code/data shared, run a separate Codex CLI session configured for DeepSeek with a read-only sandbox. Pass a bounded sanitized evidence packet and the Investigator or Independent Reviewer instructions. Bring its report and available usage back to the lead; independently validate findings. This is a separate provider session, not a native child subagent of the OpenAI lead.

The adjacent deepseek-session.example.toml is inert documentation, outside auto-loaded config paths. It is not an installed profile and no launch script automatically invokes it. Before using it, recheck model mapping, explicitly approve a budget and data transfer, set DEEPSEEK_API_KEY locally using a secret manager/environment, and configure a separate session according to official documentation. Never paste keys into chat or put them in a tracked file. Do not run official installation scripts that overwrite existing user config without inspecting and merging settings first.

A future approval-gated local bridge/MCP tool could automate report transfer and usage accounting. None was installed or activated. Separate sessions and any bridge need their own verified limits and compatibility test; provider compatibility documentation is not proof of account access or a successful inference.

Sources:
- https://api-docs.deepseek.com/updates/?release=deepseek-coder
- https://api-docs.deepseek.com/quick_start/agent_integrations/codex
- https://learn.chatgpt.com/docs/agent-configuration/subagents
- https://learn.chatgpt.com/docs/config-file/config-reference

## Prepared reviewer launcher
`scripts/Invoke-DeepSeekReviewer.ps1` now prepares a separate Codex CLI DeepSeek session with explicit provider overrides, read-only sandbox, disabled subagents, no automatic provider fallback, and zero configured transport retries. It loads DEEPSEEK_API_KEY from the process or Windows user environment without displaying it, restoring the previous process value afterward. User-level Codex config is ignored to avoid inheriting its connectors; project policy remains in effect.

The smoke test disables shell tools, apps, plugins, memories, and web search, and asks only for DEEPSEEK_CONNECTION_OK. Codex's agent context is still sent; this is not a raw API-only ping. Each execution requires an explicit -ApprovePaidUsage switch supplied only after human approval. This switch is a behavioral gate, not a billing cap. The launcher has no verified hard dollar/token cap; the Codex harness may make multiple requests. Recheck the moving alias mapping before execution.

Status: Windows user environment variable present; current parent process environment variable absent. Value was not displayed or written to a file. Launcher syntax and no-approval blocking behavior pass. Paid response test is pending user approval; no DeepSeek invocation has occurred.

## Approved connection test result � October 14, 2026
The user approved the smoke test. The first restricted-process attempt failed to initialize Codex (access denied), before provider inference. The approved elevated retry started a separate session with model deepseek-flash, provider deepseek, sandbox read-only, approval never, and tools disabled. DeepSeek's Responses endpoint returned HTTP 402 Payment Required: Insufficient Balance. No successful model response was received. No fallback model or provider was invoked and no further retry was made.

Session: 01a13d33-a9eb-74a1-bcf3-6b65c7d0682d. The CLI warned that local metadata for deepseek-flash is unknown; fallback metadata does not mean a different model was requested. Token usage and actual billed amount were not returned. No successful generation occurred, but billing was not independently inspected. Account funding is required before another response test; obtain fresh approval before retrying after funding. No application code changed or credential value was displayed.

## Approved retry after funding � October 14, 2026
Session 01a13d42-e21a-75f1-9ab1-4149ed4e3421 requested deepseek-flash through provider deepseek with read-only sandbox and tools disabled. The Responses endpoint returned HTTP 503 Service Unavailable: Service is too busy. No successful model response was received. This attempt did not return the earlier 402 error, but account balance was not independently queried. No fallback or automatic retry was initiated. Tokens and billed amount were not returned. A further paid attempt requires user approval.

## Successful approved retry � October 14, 2026
Session 01a13d48-dfbd-70b1-b8b5-795a4d2106ac completed successfully (exit 0) using requested model deepseek-flash and provider deepseek. The actual provider response was DEEPSEEK_CONNECTION_OK. Read-only sandbox and disabled model tools were used. CLI reported 8,441 tokens used; input/output breakdown and billed dollar amount were not exposed. This verifies a real DeepSeek Responses inference through the separate Codex session, not native mixed-provider child delegation or a substantive code review. The local unknown-model metadata warning remains; no alternative model was requested. The API alias is not independent proof of an immutable backend version. No application code changed, no credential value displayed, no further paid usage authorized by this test.

Reusable handoff subsequently verified end-to-end with substantive review, captured usage, and independent reconciliation. See HANDOFF.md and VERIFICATION.md for the latest status.
