$localpath = (Get-Location).path

$json  = Split-Path ( Split-Path $PSScriptRoot -Parent) -Parent

# $json = "$json\RepositoryAuditory\auditoria_hardware.json"

# $datos = Get-Content $json | ConvertFrom-JSON

$cpud = Get-CimInstance Win32_Processor | 
    Select-Object   Caption, 
                    Description, 
                    InstallDate, 
                    Name, 
                    Status, 
                    Availability, 
                    CreationClassName, 
                    DeviceID, 
                    SystemCreationClassName,
                    SystemName,
                    AddressWidth,
                    CurrentClockSpeed,
                    DataWidth,
                    LoadPercentage,
                    Role,
                    Manufacturer, 
                    MaxClockSpeed,
                    SocketDesignation,
                    NumberOfCores, 
                    NumberOfLogicalProcessors
        


    $tablaCPU = foreach($cpu in $cpud.PSObject.Properties){
                    [PSCustomObject]@{
                        PROP = $cpu.Name
                        VALUE = $cpu.Value
                    }
                }

    $cpuTbl = Get-Content ".\informe2.html" -Raw

    $cpuTbl = $cpuTbl.Replace(
        "{{ CPU_TABLE }}",
        ( $tablaCPU | ConvertTo-Html -Fragment )
    )

    $cpuTbl | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"
