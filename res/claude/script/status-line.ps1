# https://code.claude.com/docs/en/statusline#available-data
$json = $input | ConvertFrom-Json

# Limits
$limitSession = $json.rate_limits.five_hour.used_percentage ?? "?"
$limitWeek = $json.rate_limits.seven_day.used_percentage ?? "?"
$limitStr = "$limitSession% ($limitWeek% week)"

# Context
$ctx = $json.context_window.used_percentage ?? 0
$itok = $json.context_window.total_input_tokens ?? 0
$otok = $json.context_window.total_output_tokens ?? 0
$ctxStr = "$ctx% (In: $itok / Out: $otok)"

# Cost
$cost = $json.cost.total_cost_usd ?? 0
$costStr = "`${0:F2}" -f $cost

# Duration
$dur = $json.cost.total_api_duration_ms ?? 0
$durStr = [TimeSpan]::FromMilliseconds($dur).ToString("m\:ss")

# Model
$model = $json.model.display_name
$effort = $json.effort.level ?? "null"
$modelStr = "$model ($effort)"

Write-Host "Limit: $limitStr | Context: $ctxStr | Cost: $costStr | Duration: $durStr | $modelStr"
