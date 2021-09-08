
Function Sum-PipelineNumber {
    [CmdletBinding()]
    [OutputType([int])]
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [int]$num
    )

    Begin{
        $total = 0
    }
    Process{
        $total += $num
    }
    End{
        "Total = $total"
    }
}

Function Sum-PipelineNumberVerbose {
    [CmdletBinding()]
    [OutputType([int])]
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [int]$num,
        [switch]$PrintStep
    )

    Begin{
        $total = 0
        if ($PrintStep){
            Write-Verbose 'This block of code executes once per process\nAnd we are usinge this block to initialize the Total variable'
            Write-Host 'Total = 0'
        }
    }
    Process{
        $total += $num
        if ($PrintStep){
            Write-Verbose "Total = $($total - $num) + $num"
            Write-Host "Result = $total"
        }
    }
    End{
        if ($PrintStep){
            Write-Verbose "This is the end block"
            Write-Host "Total = $total"
        }
        $total
    }
}

Function Sum-PipelineNumberObject {
    [CmdletBinding()]
    [OutputType([int])]
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [int]$num
    )

    Begin{
        $total = 0
        $position = 0
        Write-Verbose 'This block of code executes once per process and we are using this block to initialize the Total and position variable'
        Write-Verbose "Total = $total"
        Write-Verbose "position = $position"
    }
    Process{
        $total += $num
        $props = @{
            'number'= $num
            'position' = $position
            'previousAmount' = $total - $num
            'result' = $total  
        }

        $Obj = New-Object -TypeName PSObject -Property $props
        Write-Output $Obj
        $position++
    }
    End{
        Write-Verbose "This is the end block"
        Write-Verbose "Total = $total"
        Write-Verbose "position = $position"
    }
}


Function Create-RicardoObject {
    [CmdletBinding()]
    [OutputType([PSObject])]
    Param(
        [Parameter(Mandatory=$true,
                   Position=0)]
        [string]$name,
        [Parameter(Mandatory=$true,
                   Position=1)]
        [string]$surname,
        [Parameter(Mandatory=$true,
                   Position=2)]
        [ValidateSet('Capoeira', 'Nadar', 'Programar', 'Ukelele', 'Patines')]
        [string[]]$hobby,
        [Parameter(Mandatory=$true,
                   Position=3)]
        [datetime]$birthday
    )

    Begin{}

    Process{
        $props = @{
            'name' = $name
            'surname' = $surname
            'fullname' = $name + ' ' + $surname
            'birthday' = $birthday
            'hobby' = $hobby
        }
        New-Object -TypeName PSObject -Property $props -OutVariable Obj
        Write-Output $Obj
    }

    End{}
}