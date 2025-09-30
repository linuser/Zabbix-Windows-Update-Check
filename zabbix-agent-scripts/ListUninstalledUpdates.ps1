# List ALL Windows Updates
# Author: Reasonable IT Service LLC
# Website: https://reasonableitservice.com/how-were-using-zabbix-7-0-to-monitor-for-windows-updates/

$UpdateSearcher = New-Object -ComObject "Microsoft.Update.Searcher"
$UpdateSearcher.Search("IsAssigned=1 and IsHidden=0").Updates | Select-Object Title, MsrcSeverity, IsInstalled | Format-Table -AutoSize | Out-String -Width 256

