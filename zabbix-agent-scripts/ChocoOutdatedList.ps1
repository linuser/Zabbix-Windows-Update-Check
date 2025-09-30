# ChocoOutdatedList.ps1
# Output: {"Count":<n>,"Packages":[{"name":"...", "current":"...", "available":"...", "pinned":"..."}]}
$ErrorActionPreference = 'Stop'

function Get-ChocoPath {
  $reg = 'HKLM:\SOFTWARE\Chocolatey'
  if (Test-Path $reg) { (Get-ItemProperty $reg).ChocolateyInstall }
  elseif ($env:ChocolateyInstall) { $env:ChocolateyInstall }
}

try {
  $base = Get-ChocoPath
  if (-not $base) { '{ "Count": 0, "Packages": [], "Error": "Chocolatey not found" }'; exit 1 }
  $exe = Join-Path $base 'bin\choco.exe'
  if (-not (Test-Path $exe)) { '{ "Count": 0, "Packages": [], "Error": "choco.exe not found" }'; exit 1 }

  $raw = & $exe outdated --limit-output --no-color 2>$null
  if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 2) { '{ "Count": 0, "Packages": [], "Error": "choco outdated failed" }'; exit 1 }

  $lines = $raw | Where-Object { $_ -and ($_ -notmatch '^Chocolatey v') }
  $pkgs = foreach ($line in $lines) {
    $p = $line -split '\|'
    if ($p.Count -ge 4) {
      [pscustomobject]@{
        name      = $p[0]
        current   = $p[1]
        available = $p[2]
        pinned    = $p[3]
      }
    }
  }

  [pscustomobject]@{ Count = ($pkgs | Measure-Object).Count; Packages = $pkgs } |
    ConvertTo-Json -Depth 3 -Compress
  exit 0
}
catch {
  '{ "Count": 0, "Packages": [], "Error": "exception" }'
  exit 1
}
