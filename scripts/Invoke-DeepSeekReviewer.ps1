[CmdletBinding()]
param(
    [switch]$ApprovePaidUsage,
    [switch]$SmokeTest,
    [string]$Task,
    [string]$TaskFile,
    [string]$ResultDirectory
)
$ErrorActionPreference = 'Stop'
if (-not $ApprovePaidUsage) {
    throw 'Paid API usage has not been approved. Obtain explicit approval before supplying -ApprovePaidUsage.'
}
if ($TaskFile) { $Task = Get-Content -LiteralPath $TaskFile -Raw }
if (-not $SmokeTest -and [string]::IsNullOrWhiteSpace($Task)) {
    throw 'Provide -SmokeTest or an approved, sanitized -Task.'
}
$previousKey = $env:DEEPSEEK_API_KEY
try {
    if ([string]::IsNullOrWhiteSpace($env:DEEPSEEK_API_KEY)) {
        $env:DEEPSEEK_API_KEY = [Environment]::GetEnvironmentVariable('DEEPSEEK_API_KEY', 'User')
    }
    if ([string]::IsNullOrWhiteSpace($env:DEEPSEEK_API_KEY)) {
        throw 'DEEPSEEK_API_KEY is unavailable. Configure it locally; do not paste it into chat.'
    }
    $repository = Split-Path -Parent $PSScriptRoot
    $codexArgs = @(
        'exec', '--ignore-user-config', '--ephemeral', '--strict-config',
        '--sandbox', 'read-only', '--color', 'never', '--cd', $repository,
        '--model', 'deepseek-flash',
        '-c', 'model_provider="deepseek"',
        '-c', 'model_reasoning_effort="low"',
        '-c', 'approval_policy="never"',
        '-c', 'agents.enabled=false',
        '-c', 'model_providers.deepseek.name="DeepSeek"',
        '-c', 'model_providers.deepseek.base_url="https://api.deepseek.com/"',
        '-c', 'model_providers.deepseek.wire_api="responses"',
        '-c', 'model_providers.deepseek.env_key="DEEPSEEK_API_KEY"',
        '-c', 'model_providers.deepseek.request_max_retries=0',
        '-c', 'model_providers.deepseek.stream_max_retries=0',
        '-c', 'features.apps=false',
        '-c', 'features.plugins=false',
        '-c', 'features.memories=false',
        '-c', 'web_search="disabled"'
    )
    if ($SmokeTest) {
        $prompt = 'Connection smoke test only. Do not use tools, read files, or delegate. Reply exactly: DEEPSEEK_CONNECTION_OK'
        $codexArgs += @('-c', 'features.shell_tool=false')
    } else {
        # Supply role behavior in the task; do not load its fixed OpenAI model setting.
        $prompt = "Act as an independent read-only reviewer. Never edit files, access credentials, delegate, or call external services. Inspect evidence independently; return severity, source location, reproduction, impact, and uncertainty. The user has authorized this separate DeepSeek call. Review scope: $Task"
    }
    if ($ResultDirectory) {
        $ResultDirectory = (Resolve-Path -LiteralPath $ResultDirectory).Path
        $codexArgs += @('--json', '--output-last-message', (Join-Path $ResultDirectory 'findings.md'))
        # Snapshot review: no shell access; Codex still includes repository instruction context.
        $codexArgs += @('-c', 'features.shell_tool=false')
        $events = @($prompt | & codex @codexArgs '-' 2> (Join-Path $ResultDirectory 'diagnostics.log'))
        $sessionExit = $LASTEXITCODE
        $events | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $ResultDirectory 'events.jsonl')
        if ($sessionExit -ne 0) { throw "DeepSeek Codex session exited with code $sessionExit. See local diagnostics; no fallback was invoked." }
    } else {
        & codex @codexArgs $prompt
        $sessionExit = $LASTEXITCODE
    }
    if ($sessionExit -ne 0) { throw "DeepSeek Codex session exited with code $sessionExit. No fallback provider was invoked." }
} finally {
    $env:DEEPSEEK_API_KEY = $previousKey
}

