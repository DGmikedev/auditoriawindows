param(
    [string]$TYPE
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"

function Get-Cpu($TYPE){

    try {
    $cpu =  Get-CimInstance Win32_Processor |
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

        $CpuR = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-Cpu.psm1" -DATA $cpu -TYPE $TYPE

        return  $CpuR

    }catch{

        $msg = $_.Exception.Message

        $CpuR = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $CpuR

    }

}

#Get-Cpu -TYPE $TYPE
Export-ModuleMember Get-Cpu