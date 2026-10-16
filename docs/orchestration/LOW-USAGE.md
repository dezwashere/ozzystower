# Permanent low-usage policy and DeepSeek assessment

Applied October14,2026 to OzzysTower only. No global Codex settings, application files, dependencies, providers or paid calls changed. Ozzy remains lead and all six specialists remain available. Backups of prior policy/config are in the Git-ignored .ozzystower/local-artifacts/efficiency-before directory.

## Defaults
Lead/default specialist Luna/low; at most one concurrent specialist. Simple work stays with Ozzy. Developer/Tester Luna/low; Investigator/ordinary Reviewer Luna/medium; Architect/Security Auditor Sol/medium. High-effort Sol/Astra, broad investigations, repeated specialist rounds and parallel work require prior approval and a concrete benefit/stop condition. No default full team or mandatory review cascade. Luna is an affordable supported candidate; exact account model consumption multipliers are not available, so this is not proof of the cheapest model on every task.

Usage checks are event-based; warning threshold75% and substantial-work approval threshold90% in either reported window. These are operating thresholds, not a token/dollar enforcement mechanism. If usage is unavailable, report unknown. Never buy credits, use reset credits, invoke another paid provider or install services automatically.

## DeepSeek integration is preserved
The working scripts, existing provider/model/Responses endpoint, credential loading, read-only sandbox, capture-mode tool restrictions, approval gates, no-fallback/no-retry behavior, report files and usage ledger are unchanged. Automatic capture returns findings/task paths to Ozzy. Optional Codex reviewer dispatch still works when justified; it is no longer a mandatory additional charge in subscription usage.

Selecting DeepSeek requires explicit human approval of each paid attempt and the data shared. Use it instead of an additional Codex reviewer for a bounded diff, a contained algorithm or test-gap review, or an independent hypothesis challenge. Ozzy must still validate actionable findings. For high-impact security/auth/data-loss changes, use proportionate expert verification; do not assume external review replaces it safely. Do not run both by habit. Failed provider calls do not authorize another attempt or a provider/model substitution.

## Observed evidence, not a benchmark
The previously successful real sample review at run12f4c3d5-a4c4-45e5-88d1-5221b5b81f78 reported8727 input tokens, including8064 cached input, and1136 output tokens. It found the empty-list bug. The independent Codex reviewer confirmed that finding but reduced inflated severity, rejected a duplicate finding and corrected an invalid import/unsupported coverage assertion. One harmless example is insufficient to rank general review quality.

Previous invocations include HTTP402 insufficient balance and HTTP503 service-busy failures; a later smoke test and substantive review succeeded. These demonstrate real integration plus reliability limitations, not a measured availability rate. No new live test was performed for this change.

## Published API rates and explicit estimates
DeepSeek's official pricing checked October14 identifies deepseek-flash as V4.1 Flash. USD per million tokens: peak cached input0.006, uncached input0.30, output1.20; off-peak0.003/0.15/0.60. Prices can change. Source: https://api-docs.deepseek.com/quick_start/pricing/

For the recorded sample, treating1136 output as inclusive of its separately reported reasoning count, the calculation is(8064*cached rate +663*uncached rate +1136*output rate)/1,000,000. Estimated price at these rates:$0.001610484 peak or$0.000805242 off-peak. Without any cache hits, same token volumes estimate$0.0039813 peak or$0.00199065 off-peak. These are illustrative current-rate estimates, not the charged historical amount or a future spending cap. Reasoning/cache categories must not be double-counted. Actual cost_usd in the ledger correctly remains null because no invoice/charged amount was returned.

## Subscription and workflow tradeoffs
An approved DeepSeek review replaces the specialist's OpenAI inference with a separately billed provider call. Codex still consumes usage preparing and reconciling the packet, so zero Codex consumption is not claimed. The exact allowance saved per review is unmeasured. Within unused subscription allowance, a Codex review has no separate API invoice; DeepSeek adds cash expense even if the nominal token price is small. It may be useful when preserving allowance has higher value, not automatically cheaper overall.

Snapshot-only DeepSeek review cannot run tests/tools or inspect unprovided dependencies, so context selection matters. The real tiny sample still consumed thousands of input tokens due to harness/instruction context. Keep packets bounded and relevant; fewer redundant reviews matter more than nominal cheap-token pricing. More context and correction work can erase savings. API availability, external source transfer, caches and possible future pricing are additional tradeoffs.

Measured savings: none. Structural opportunity: one rather than three specialist sessions is67% fewer child sessions for a comparable delegation shape, not67% fewer total tokens or allowance. Simple tasks use zero specialists. Record real task usage when exposed, but do not run paid benchmarks merely to measure savings without approval.

## Lightweight verification
Validate TOML/role routing and protected-file hashes locally. Run the existing six mocked handoff tests, PowerShell parsing and unpaid-launch rejection. Preserve prior successful live evidence; offline tests do not establish current provider health. No new agents, inference or paid connection tests are required to verify these configuration edits.

## Applied verification result
Root TOML and all six role files parse and match the approved low-usage routing. Permissions remain on-request/workspace-write. SHA256 comparison confirms both DeepSeek execution scripts, existing test file, inert provider example and global Codex config/instruction file state are unchanged. Six existing mocked handoff tests pass, covering blocked unapproved execution, stale source guard, sensitive/path guard, success/usage capture, failure capture and atomic attempt claim. PowerShell launcher syntax and unapproved-invocation rejection pass. No real Codex inference/DeepSeek provider test or agent was started by these checks; previous real provider success remains the integration evidence. New-session behavior/provider health is not established by offline checks. git diff --check passes.

Model/concurrency defaults apply when OzzysTower configuration is loaded in a fresh session; the current chat's root model was not switched by editing files. Other projects/global settings were not changed. No measured savings are claimed.

