
Function Get-MyLogicalDisk {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName='localhost',
        [string]$Drive='c:'
    )

    Get-WmiObject Win32_logicalDisk -Filter "DeviceID='$Drive'" -ComputerName $ComputerName
}
