
[string]$owner_name="Ricardo Maximino"
[int]$owner_age=38
[datetime]$owner_birthday="11/15/1982"
[validateset("Ricardo","Maximino","Gonçalves","de","Moraes")] [string] $oneName = "Ricardo"

Get-Service -Name n* | Out-File file.txt
Get-Service -Name n* | Export-Csv file.csv
Get-Service -Name n* | Export-Clixml file.xml
Get-Content -Path file.txt
Get-Content -Path file.csv
Get-Content -Path file.xml


If (1 -eq 2) {
    Write-Output "1 -eq 2"
} elseif (2 -gt 1) {
    Write-Output "2 -gt 1"
} elseif (2 -ne 2) {
    Write-Output "2 -ne 2"
}else {
    Write-Output"Else"
}

$if_result = If (1 -eq 2) {
   '1 -eq 2'
} elseif (2 -gt 1) {
    '2 -gt 1'
} elseif (2 -ne 2) {
    '2 -ne 2'
}else {
    'Else'
}
 
 $if_result

$status = 1
Switch ($status) {
 0 {$status_text = 'Zero'}
 1 {$status_text = 'One'}
 2 {$status_text = 'Two'}
 default {$status_text = 'Unkown'}
}

$status_text

# cleaner way
$status = 1
$status_text = Switch ($status) {
 0 {'Zero'}
 1 {'One'}
 2 {'Two'}
 default {'Unkown'}
}

$status_text

$i = 1
Do {

    Write-Output "The variable i is: $i"
    $i++
    #$i--
    #$i-=2
    #$i+=2
} while ($i -le 5)



$services = Get-Service -Name n*

ForEach ($service in $services) {
    $service.Displayname
}

For ($i=0;$i -lt 5;$i++){
    $services[$i].DisplayName
}

1..5 | ForEach-Object -Process {
    start calc
    sleep 1
}

Get-EventLog -LogName System  -Newest 3

Get-WmiObject -Class win32_bios

Get-WmiObject Win32_logicalDisk -Filter "DeviceID='C:'" -ComputerName localhost


Get-PSDrive

#dir Function:
Get-ChildItem Function:

Remove-Item Function:\Get-MyLogicalDisk

$computer_list = 'localhost', 'localhost'

forEach ($s in (Get-Service -Name n*)){
    $s.DisplayName
}

#Invoke-Command -ComputerName "machine_name" r{Get-Service -Name n*}