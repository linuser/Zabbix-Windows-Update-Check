Template Windows Updates (PlaNet_Fox_25)

Dieses Zabbix-Template dient der Überwachung von Windows-Updates mit dem Zabbix Agent2 und speziell bereitgestellten PowerShell-Skripten. Es ermöglicht die zentrale Kontrolle des Update-Status von Windows-Systemen und Chocolatey-Paketen.

Funktionen:
	•	Überwachung der Anzahl und Schwere von ausstehenden Windows-Updates (Critical, Important, Moderate, Low, Unknown, Total).
	•	Erfassung der Tage seit dem letzten Update sowie des letzten erfolgreichen Update-Scans.
	•	Erkennung, ob ein Neustart nach Updates erforderlich ist.
	•	Integration von Chocolatey: Abfrage veralteter Pakete (Liste & Anzahl).
	•	Visuelle Darstellung über ein integriertes Dashboard und ein Graph mit Updates nach Schweregrad.
	•	Alarmierung bei kritischen Zuständen (z. B. ausstehende Updates, veraltete Pakete, fehlende Update-Suche).

Voraussetzungen:
	•	Zabbix Agent2 mit UserParameters.
	•	PowerShell-Skripte im Verzeichnis
C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\.


This Zabbix template is designed to monitor Windows Updates using Zabbix Agent2 with dedicated PowerShell scripts. It provides comprehensive visibility into the update status of Windows systems and installed Chocolatey packages.

Features:
	•	Monitoring of pending Windows Updates by severity (Critical, Important, Moderate, Low, Unknown, Total).
	•	Tracking days since the last update and the last successful update search.
	•	Detection of whether a reboot is required after updates.
	•	Chocolatey integration: retrieves outdated package list and count.
	•	Built-in dashboard and graph for visual overview of update status.
	•	Triggers and alerts for critical conditions (e.g., pending critical updates, outdated packages, missing update checks).

Requirements:
	•	Zabbix Agent2 with configured UserParameters.
	•	PowerShell scripts placed in:
C:\Program Files\Zabbix Agent 2\zabbix-agent-scripts\
