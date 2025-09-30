param(
    [ValidateSet('Total','Critical','Important','Moderate','Low','Unknown')]
    [string]$Severity = 'Total'
)
$ErrorActionPreference = 'Stop'
try {
    $session  = New-Object -ComObject Microsoft.Update.Session
    $searcher = $session.CreateUpdateSearcher()

    # Pending, not hidden, software updates
    $result   = $searcher.Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    $updates  = @($result.Updates)

    if ($Severity -eq 'Total') {
        [int]$count = $updates.Count
        Write-Output $count
        exit 0
    }

    $mapped = $updates | ForEach-Object {
        $sev = $_.MsrcSeverity
        if ([string]::IsNullOrWhiteSpace($sev)) { $sev = 'Unknown' }
        # Normalize
        switch -Regex ($sev) {
            '^Critical$'  { $sev = 'Critical' ; break }
            '^Important$' { $sev = 'Important'; break }
            '^Moderate$'  { $sev = 'Moderate' ; break }
            '^Low$'       { $sev = 'Low'      ; break }
            default       { $sev = 'Unknown'  ; break }
        }
        [pscustomobject]@{ Title = $_.Title; Severity = $sev }
    }

    $sel = $mapped | Where-Object { $_.Severity -eq $Severity }
    [int]$out = @($sel).Count
    Write-Output $out
    exit 0
} catch {
    Write-Output -1
    exit 0
}
