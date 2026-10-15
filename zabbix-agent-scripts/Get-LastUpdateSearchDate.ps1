# Get-LastUpdateSearchDate.ps1
# Unix-Zeitstempel (UTC) der letzten belegbaren Windows-Update-Aktivitaet
# fuer das Item windows.update.lastsearch. -1 = nichts ermittelbar.
#
# Genommen wird der juengste von drei Zeitpunkten:
#   1. letzte erfolgreiche Suche des Windows-Update-Dienstes
#      (Microsoft.Update.AutoUpdate -> Results.LastSearchSuccessDate)
#   2. letzte erfolgreiche Installation (Results.LastInstallationSuccessDate)
#   3. neuester Eintrag im Update-Verlauf (QueryHistory)
#
# Frueher nur Punkt 3 - das ist das letzte INSTALLIERTE Update, keine Suche:
# ein Server, der sucht und nichts findet, galt nach 25 Tagen als "sucht
# nicht". Punkt 1 allein reicht aber auch nicht: ist die automatische Suche
# per GPO aus und sucht ein Werkzeug wie Ansible ueber die COM-Schnittstelle,
# erscheint diese Suche dort nicht. Der juengste Wert der drei ist deshalb nie
# schlechter als der alte und besser, wo der Dienst selbst sucht.
#
# Alle drei Quellen liefern UTC. Get-Date -UFormat %s rechnete in Windows
# PowerShell 5.1 mit Ortszeit - der Wert lag um den UTC-Versatz daneben.
$ErrorActionPreference = "Stop"

function Als-Unix([object]$datum) {
    if ($null -eq $datum) { return $null }
    $d = [datetime]$datum
    if ($d.Year -lt 2000) { return $null }   # leere COM-Datumswerte (1899/1601)
    $utc = [datetime]::SpecifyKind($d, [System.DateTimeKind]::Utc)
    return ([DateTimeOffset]$utc).ToUnixTimeSeconds()
}

$werte = @()

try {
    $ergebnisse = (New-Object -ComObject Microsoft.Update.AutoUpdate).Results
    $werte += Als-Unix $ergebnisse.LastSearchSuccessDate
    $werte += Als-Unix $ergebnisse.LastInstallationSuccessDate
} catch { }

try {
    $sucher = (New-Object -ComObject Microsoft.Update.Session).CreateUpdateSearcher()
    if ($sucher.GetTotalHistoryCount() -gt 0) {
        $werte += Als-Unix ($sucher.QueryHistory(0, 1) | Select-Object -First 1).Date
    }
} catch { }

$werte = @($werte | Where-Object { $null -ne $_ })
if ($werte.Count -gt 0) {
    # [long]: Measure-Object liefert Double, Zabbix erwartet eine Ganzzahl.
    [long](($werte | Measure-Object -Maximum).Maximum)
} else {
    -1
}
