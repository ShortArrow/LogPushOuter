param (
    [switch]$Debug # オプション
)

function Test-Admin {
    $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
    $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $prp.IsInRole($adm)
}
function MyLog {
    param($Behavior, $Target, $Result)
    if (!(Test-Path $SettingFile.LogFolder)) {
        New-Item $SettingFile.LogFolder -ItemType Directory -Force
    }
    $LogFile = $SettingFile.LogFolder + "\lpolog" + (Get-Date -Format "yyyyMMdd") + ".log"
    Write-Output ("""{0}"",""{1}"",""{2}"",""{3}"",""{4}""" `
            -f (Get-Date -Format "yyyyMMdd"), (Get-Date -Format "HHmmss"), $Behavior, $Target, $Result) |
    Out-File -LiteralPath $LogFile -Append -Force
}

function Push-Queue {
    param (
        $Path,
        $QueueLength
    )
    Set-Location $Path
    $MostOlder = (Get-Date)
    while ((Get-ChildItem $Path | Where-Object { ! $_.PsIsContainer }).Count -gt $QueueLength) {
        foreach ($item in (Get-ChildItem)) {
            if (! $item.PSIsContainer) {
                if ($MostOlder -ge $item.CreationTime) {
                    $MostOlder = $item.CreationTime
                }
                if ($MostOlder = $item.CreationTime) {
                    MyLog -Behavior "delete" -Target $item.FullName -Result "before"
                    Write-Host $item Delete !!
                    Remove-Item $item
                    if (!(Test-Path $item)) {
                        MyLog -Behavior "delete" -Target $item.FullName -Result "success"
                    }
                    else {
                        MyLog -Behavior "delete" -Target $item.FullName -Result "failure"
                    }
                    break
                }
            }
        }
    }
}
    
    
function Start-Main {
    param (
            
    )
        
    if ([int]$psversiontable.psversion.major -gt 6) {
        Write-Host "PowerShell version need 5 or later" -BackgroundColor Red -ForegroundColor Black
        return
    }
            
    if ((Test-Admin) -eq $false) {
        Write-Host 'You need Administrator privileges to run this.' -BackgroundColor Red -ForegroundColor Black
        return
    }
            
            
            
    foreach ($path in $SettingFile.path) {
        if (Test-Path $path) {
            # Write-Host $path
            Push-Queue -path $path -QueueLength $SettingFile.QueueSize
        }
        else {
            MyLog -Behavior "find" -Target $path -Result "not found"
        }
    }
    Push-Queue -Path $SettingFile.LogFolder -QueueLength $SettingFile.LogCount
            
}
        
        
$SettingFile = ( Get-Content -Raw .\settings.json -Encoding UTF8 | ConvertFrom-Json)
MyLog -Behavior "run" -Target "process" -Result "start"
Start-Main
MyLog -Behavior "run" -Target "process" -Result "finish"
Write-Host "Finish" -BackgroundColor Green -ForegroundColor Black
exit