get-service | Export-Csv -Path c:\powershell_test\export.csv
Get-Process | Export-Clixml -Path c:\powershell_test\export.xml
Import-Csv C:\powershell_test\export.csv
Compare-Object -ReferenceObject (Import-Clixml C:\powershell_test\export.xml) -DifferenceObject (Get-Process) -Property name
Get-Service | ConvertTo-Html -Property name,status | Out-File C:\powershell_test\export.html
Get-Service -DisplayName *ocker* | Stop-Service -WhatIf
Get-Module -ListAvailable
Get-Process | where handles -gt 500 | sort handles
Get-Process | Get-Member
Get-Process | Select -Property id,name,modules | where id -lt 10 | sort id

$fileContent = [xml](Get-Content -Path C:\powershell_test\export.xml)
$fileContent.GetType()
$fileContent.Objs.Obj.T.Count |group T | sort Obj
Get-Service | where {$_.status -eq "running" -and $_.name -like "WS*"}
Get-WmiObject -Class win32_bios

https://learn.microsoft.com/en-us/powershell/module/pki/new-selfsignedcertificate?view=windowsserver2022-ps
Get-PSDrive
Get-ChildItem Cert:\LocalMachine\MY -Recurse -CodeSigningCert -OutVariable certList
$cert = $certList[0]
Set-AuthenticodeSignature -Certificate $cert -FilePath .\script.ps1

Write-Host "Hello World!!" -ForegroundColor White -BackgroundColor Green
Write-Output "Hello World!!"
Write-Warning "Attention!!"
Write-Error "Danger!!"

Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'" | Select @{n='freegb';e={$_.freespace / 1gb -as [int]}}

Get-NetIPAddress
Test-Connection "google.es"
Test-NetConnection -ComputerName "google.es" -Port 80
Get-NetAdapter
Get-NetAdapterStatistics -Name "Ethernet"
Get-NetTCPConnection
Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }
Get-DnsClientServerAddress
Resolve-DnsName -Name "brasatech.es" -Type A
Resolve-DnsName -Name "brasatech.es" -Type MX
Get-NetNeighbor

Get-TimeZone
[System.Environment]::SetEnvironmentVariable("Test", "Value", "Machine")
[System.Environment]::SetEnvironmentVariable("Test", "", "Machine")
whoami

<#
.Synopsis
This is the short explanation
.Description
This is the long description
.Parameter names
This is to decide if it should run
.Example
AU-Run-Middleware true
#>
function Get-Info {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [String[]]$names,
        [String]$country
    )
    Write-Host $names $country

}


Invoke-WebRequest -Uri "brasatech.es" -OutFile "C:\powershell_test\brasatech.html" -PassThru


Invoke-RestMethod -Uri "http://randomuser.me/api" -Method Get
Invoke-WebRequest -Uri "http://randomuser.me/api" -Method Get

$response = Invoke-WebRequest -Uri "http://randomuser.me/api" -Method Get 
$psResponse = $response.Content | ConvertFrom-Json 

$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}
$hash.keys | ForEach-Object { "The value of '$_' is: $($hash[$_])" }
$hash.GetEnumerator().ForEach({"The value of '$($_.Key)' is: $($_.Value)"})
$hash["Time"] = (Get-Date)
$hash.Add("Future", "Tomorrow")
$hash.Remove("Time")


New-Item -ItemType File -Path . -Name repositories.conf
$repositories = Get-Content -Path .\repositories.conf
$repObjList = $repositories | ForEach-Object { $line = $_ -split ","; [ordered]@{folder = $line[0]; branch = $line[1]; remote = $line[2]}} 
$repositories | ForEach-Object { $line = $_ -split ","; [ordered]@{folder = $line[0]; branch = $line[1]; remote = $line[2]}}

foreach($rep in $repObjList) {    $folderPath =  ".\source\", $rep.folder -join ''; New-Item -ItemType Directory -Name $folderPath  }

foreach($rep in $repObjList) {
    $baseDir = "C:\powershell_test\source"
    if((Test-Path $baseDir) -eq $false) {
        New-Item -ItemType Directory -Path $baseDir
    }
    $repoDir =  $baseDir,"\", $rep.folder -join '';
    if(Test-Path -Path $repoDir) {
        Set-Location -Path $repoDir
        git pull
    } else {
        Set-Location $baseDir
        git clone ($rep.remote.Replace("-token-", "token"))
        Set-Location -Path $rep.folder
        git checkout $rep.branch
    }
    Set-Location -Path $baseDir
}
