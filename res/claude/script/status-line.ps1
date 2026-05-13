# https://code.claude.com/docs/en/statusline#available-data
$json = $input | ConvertFrom-Json

# Context
$ctx = $json.context_window.used_percentage ?? 0
$itok = $json.context_window.total_input_tokens ?? 0
$otok = $json.context_window.total_output_tokens ?? 0
$ctxStr = "$Ctx% ($itok / $otok)"

# Cost
$cost = $json.cost.total_cost_usd ?? 0
$costStr = "`${0:F2}" -f $cost

# Duration
$dur = $json.cost.total_api_duration_ms ?? 0
$durStr = [TimeSpan]::FromMilliseconds($dur).ToString("m\:ss")

Write-Host "Ctx: $ctxStr | Cost: $costStr | Dur: $durStr"
