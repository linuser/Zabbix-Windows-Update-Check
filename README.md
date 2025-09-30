# 🪟 Template Windows Updates (PlaNet_Fox_25)

Dieses **Zabbix-Template** dient der Überwachung von Windows-Updates mit dem **Zabbix Agent2** und speziell bereitgestellten **PowerShell-Skripten**.  
Es ermöglicht die zentrale Kontrolle des Update-Status von Windows-Systemen und installierten **Chocolatey-Paketen**.

---

## 🚀 Features (Deutsch)
- Überwachung der Anzahl und Schwere von ausstehenden Windows-Updates  
  _(Critical, Important, Moderate, Low, Unknown, Total)_
- Erfassung der Tage seit dem letzten Update und dem letzten erfolgreichen Update-Scan
- Erkennung, ob ein Neustart nach Updates erforderlich ist
- **Chocolatey-Integration**: Abfrage veralteter Pakete (Liste & Anzahl)
- Integriertes Dashboard und Graph mit Updates nach Schweregrad
- Triggers & Alerts für kritische Zustände  
  _(z. B. ausstehende Updates, veraltete Pakete, fehlende Update-Suche)_

---

## 📋 Voraussetzungen
- **Zabbix Agent2** mit konfigurierten `UserParameters`
- PowerShell-Skripte im Verzeichnis:

```
C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\
```

- Chocolatey (falls Paketüberwachung genutzt werden soll)

---

## ⚙️ UserParameters für den Zabbix Agent2

```ini
# Windows Update
UserParameter=CountUninstalledUpdates,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CountUninstalledUpdates.ps1"
UserParameter=DaysSinceLastUpdate,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\DaysSinceLastUpdate.ps1"
UserParameter=ListUninstalledUpdates,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\ListUninstalledUpdates.ps1"
UserParameter=CountUpdatesBySeverity[*],powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CountUpdatesBySeverity.ps1" -Severity "$1"
UserParameter=RebootRequired,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CheckRebootRequired.ps1"
UserParameter=pending.updates.json,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\ListPendingUpdatesJson.ps1"
UserParameter=windows.update.lastsearch,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\Get-LastUpdateSearchDate.ps1"

# Chocolatey
UserParameter=choco.outdated.count,powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "(choco outdated | Select-String '|' | Measure-Object).Count"
UserParameter=choco.outdated.list,powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "choco outdated | Select-String '|'"
```

---

## 📊 Dashboard & Visuals
- Übersichtliches Dashboard mit allen Update-Informationen
- Graph: Anzahl Updates nach Schweregrad
- Trigger-Übersicht für schnelle Reaktion auf kritische Zustände

---

## 📂 Beispiel-Repo-Struktur

```
├── README.md
├── zabbix_template_windows_updates.xml   # Zabbix-Template
└── scripts/
    ├── CountUninstalledUpdates.ps1
    ├── DaysSinceLastUpdate.ps1
    ├── ListUninstalledUpdates.ps1
    ├── CountUpdatesBySeverity.ps1
    ├── CheckRebootRequired.ps1
    ├── ListPendingUpdatesJson.ps1
    └── Get-LastUpdateSearchDate.ps1
```

---

## 📝 Hinweise
- Skripte sollten mit **ExecutionPolicy Bypass** laufen dürfen
- Zabbix Agent2 benötigt Lesezugriff auf die Skripte
- Chocolatey muss installiert sein, wenn die Integration genutzt wird

---

# 🪟 Template Windows Updates (PlaNet_Fox_25) – English

This **Zabbix template** is designed to monitor Windows Updates with **Zabbix Agent2** and dedicated **PowerShell scripts**.  
It provides centralized visibility into the update status of Windows systems and installed **Chocolatey packages**.

---

## 🚀 Features (English)
- Monitoring the number and severity of pending Windows Updates  
  _(Critical, Important, Moderate, Low, Unknown, Total)_
- Tracking days since the last update and the last successful update scan
- Detecting if a reboot is required after updates
- **Chocolatey integration**: retrieves outdated packages (list & count)
- Built-in dashboard and graph for update severity overview
- Triggers & Alerts for critical conditions  
  _(e.g., pending critical updates, outdated packages, missing update checks)_

---

## 📋 Requirements
- **Zabbix Agent2** with configured `UserParameters`
- PowerShell scripts located in:

```
C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\
```

- Chocolatey (if package monitoring is desired)

---

## ⚙️ UserParameters for Zabbix Agent2

```ini
# Windows Update
UserParameter=CountUninstalledUpdates,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CountUninstalledUpdates.ps1"
UserParameter=DaysSinceLastUpdate,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\DaysSinceLastUpdate.ps1"
UserParameter=ListUninstalledUpdates,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\ListUninstalledUpdates.ps1"
UserParameter=CountUpdatesBySeverity[*],powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CountUpdatesBySeverity.ps1" -Severity "$1"
UserParameter=RebootRequired,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\CheckRebootRequired.ps1"
UserParameter=pending.updates.json,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\ListPendingUpdatesJson.ps1"
UserParameter=windows.update.lastsearch,powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\Get-LastUpdateSearchDate.ps1"

# Chocolatey
UserParameter=choco.outdated.count,powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "(choco outdated | Select-String '|' | Measure-Object).Count"
UserParameter=choco.outdated.list,powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "choco outdated | Select-String '|'"
```

---

## 📊 Dashboard & Visuals
- Dashboard with full update information
- Graph: updates by severity
- Trigger overview for quick reaction to critical states

---

## 📂 Example Repo Structure

```
├── README.md
├── zabbix_template_windows_updates.xml   # Zabbix template
└── scripts/
    ├── CountUninstalledUpdates.ps1
    ├── DaysSinceLastUpdate.ps1
    ├── ListUninstalledUpdates.ps1
    ├── CountUpdatesBySeverity.ps1
    ├── CheckRebootRequired.ps1
    ├── ListPendingUpdatesJson.ps1
    └── Get-LastUpdateSearchDate.ps1
```

---

## 📝 Notes
- Scripts must be allowed to run with **ExecutionPolicy Bypass**
- Zabbix Agent2 needs read access to the scripts
- Chocolatey must be installed if the integration is used

---

✍️ Maintainer: **PlaNet_Fox_25**
