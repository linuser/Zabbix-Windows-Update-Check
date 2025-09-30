$ErrorActionPreference = 'Stop'
try {
  $base = (Get-ItemProperty 'HKLM:\SOFTWARE\Chocolatey' -ErrorAction SilentlyContinue).ChocolateyInstall
  if (-not $base) { $base = $env:ChocolateyInstall }
  if (-not $base) { 'Chocolatey not found'; exit 1 }
  $exe = Join-Path $base 'bin\choco.exe'
  if (-not (Test-Path $exe)) { 'choco.exe not found'; exit 1 }

  $raw = & $exe outdated --limit-output --no-color 2>$null
  if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 2) { 'choco outdated failed'; exit 1 }

  $lines = $raw | Where-Object { $_ -and ($_ -notmatch '^Chocolatey v') }
  if (-not $lines) { 'No outdated packages.'; exit 0 }

  foreach ($line in $lines) {
    $p = $line -split '\|'
    if ($p.Count -ge 3) { "{0} {1} -> {2}" -f $p[0], $p[1], $p[2] }
  }
  exit 0
} catch { "Error: $_"; exit 1 }
