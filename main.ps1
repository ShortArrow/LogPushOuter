param (
    [switch]$Debug # オプション
)

function Test-Admin {
    $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
    $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $prp.IsInRole($adm)
}

if ([int]$psversiontable.psversion.major -le 3) {
    Write-Host "PowerShell version need 3 or later" -BackgroundColor Red -ForegroundColor White
}
else {
    Write-Host "PowerShell version is Fit" -BackgroundColor Green -ForegroundColor White
}

if ((Test-Admin) -eq $false) {
    Write-Host 'You need Administrator privileges to run this.' -BackgroundColor Red -ForegroundColor White
    return
}


Write-Host "-------Process Wait--------"
New-Item "c:\LogPushOuter" -ItemType Directory -Force
$LogFile = "c:\LogPushOuter\lpolog" + (Get-Date).Year + (Get-Date).Month + (Get-Date).Day + ".log"
Get-Date | Out-File -LiteralPath $LogFile -Append -Force
Get-ChildItem | ForEach-Object { ((Get-Date).date - $_.LastWriteTime.date).days -le 9 }

if ($Debug) {
    $WaitTime = 5
}
else {
    $WaitTime = 900
}

Write-Host "Fin" -BackgroundColor Green -ForegroundColor White

