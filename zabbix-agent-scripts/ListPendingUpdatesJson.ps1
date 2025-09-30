# ListPendingUpdatesJson.ps1
$ErrorActionPreference = 'SilentlyContinue'
$s = New-Object -ComObject Microsoft.Update.Session
$r = $s.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")

$arr = @()
foreach ($u in @($r.Updates)) {
    $sev = if ([string]::IsNullOrWhiteSpace($u.MsrcSeverity)) { "Unknown" } else { $u.MsrcSeverity }
    $arr += [pscustomobject]@{
        Title       = $u.Title
        Severity    = $sev
        KBs         = ($u.KBArticleIDs -join ",")
        IsDownloaded= $u.IsDownloaded
    }
}

$obj = [pscustomobject]@{
    Count     = $arr.Count
    Critical  = ($arr | ? Severity -eq 'Critical').Count
    Important = ($arr | ? Severity -eq 'Important').Count
    Moderate  = ($arr | ? Severity -eq 'Moderate').Count
    Low       = ($arr | ? Severity -eq 'Low').Count
    Unknown   = ($arr | ? Severity -eq 'Unknown').Count
    Updates   = $arr
}
$obj | ConvertTo-Json -Depth 4 -Compress