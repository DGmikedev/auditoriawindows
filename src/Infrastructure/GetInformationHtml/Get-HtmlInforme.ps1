
# Datos de reporte
 $IDEQP = 1234567890



$ScrPath  = Split-Path ( Split-Path $PSScriptRoot -Parent) -Parent

# Paths of modules
    $CpuMod = Join-Path $ScrPath "\Modules\Get-Cpu.psm1"

# Import Modules
    Import-Module $CpuMod


# Get HTML Template
    $cpuTbl = Get-Content ".\template.html" -Raw

    $cpuTbl = $cpuTbl.Replace(

        "{{ IDEQP }}",
        "$IDEQP"

    )

# Use of function GET

    
    $cpu = Get-Cpu -TYPE "raw"

    # Transponse cpu data table
    $tablaCPU = foreach($cpu in $cpu.DATA.PSObject.Properties){

                    [PSCustomObject]@{
                        PROPERTY  = $cpu.Name
                        VALUE = $cpu.Value
                    }
                }
    

    

    $cpuTbl = $cpuTbl.Replace(

        "{{ CPU_TABLE }}",

        ( $tablaCPU | ConvertTo-Html -Fragment )

    )

    $cpuTbl | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"

Exit 1

<#
    $cpud = 

    $tablaCPU = foreach($cpu in $cpud.PSObject.Properties){

                    [PSCustomObject]@{
                        PROPERTY  = $cpu.Name
                        VALUE = $cpu.Value
                    }
                }

    $cpuTbl = Get-Content ".\template.html" -Raw

    $cpuTbl = $cpuTbl.Replace(

        "{{ CPU_TABLE }}",

        ( $tablaCPU | ConvertTo-Html -Fragment )

    )

    $cpuTbl | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"
#>