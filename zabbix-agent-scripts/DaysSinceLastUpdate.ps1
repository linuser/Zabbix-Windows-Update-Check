# DaysSinceLastUpdate.ps1
# Gibt die Anzahl der Tage seit der letzten erfolgreichen Windows Update-Installation zurück.
# Rückgabe: Integer (0 = heute, 1 = gestern, …)

$ErrorActionPreference = 'Stop'

try {
    $session  = New-Object -ComObject Microsoft.Update.Session
    $searcher = $session.CreateUpdateSearcher()

    # Letztes Update aus dem Verlauf suchen
    $historyCount = $searcher.GetTotalHistoryCount()
    if ($historyCount -eq 0) {
        Write-Output 0
        exit 0
    }

    $lastUpdate = $searcher.QueryHistory(0,1) | Select-Object -First 1

    if ($lastUpdate -and $lastUpdate.Date) {
        $days = (New-TimeSpan -Start $lastUpdate.Date -End (Get-Date)).Days
        Write-Output $days
        exit 0
    }
    else {
        Write-Output -1
        exit 1
    }
}
catch {
    Write-Output -1
    exit 1
}
