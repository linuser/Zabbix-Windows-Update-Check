# Get-LastUpdateSearchDate.ps1
$ErrorActionPreference = "Stop"

try {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()

    # Search history: parameter 0 = starting record, -1 = all
    $history = $updateSearcher.QueryHistory(0, 1)

    if ($history.Count -gt 0) {
        # Take the newest record
        $lastSearch = $history[0].Date
        # Output as Unix timestamp (Zabbix mag Zahlen)
        [int][double](Get-Date $lastSearch -UFormat %s)
    }
    else {
        -1   # nichts gefunden → -1
    }
}
catch {
    -1       # Fehler → -1
}
