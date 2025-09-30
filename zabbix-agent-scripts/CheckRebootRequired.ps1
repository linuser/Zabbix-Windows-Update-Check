# CheckRebootRequired.ps1
$ErrorActionPreference = 'SilentlyContinue'

# Verschiedene Registry-Pfade, die Windows bei pending reboots setzt
$paths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired",
    "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations"
)

$needsReboot = $false
foreach ($p in $paths) {
    if (Test-Path $p) {
        $needsReboot = $true
        break
    }
}

if ($needsReboot) {
    Write-Output 1
} else {
    Write-Output 0
}
exit 0
