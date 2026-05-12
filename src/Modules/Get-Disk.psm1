param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"

function Get-Disk($TYPE){
    try{
    
        $disk = Get-CimInstance Win32_LogicalDisk | 
                Select-Object DeviceID, 
                    Size, 
                    FreeSpace

        $RDisk = New-Result -STATUS 1 -MSG "Disk data was obtained succesfull " -DATA $disk -TYPE $TYPE
        
        return  $RDisk
        
     }catch{

        $msg = $_.Exception.Message

        $RDisk = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $RDisk

    }

}

Export-ModuleMember Get-Disk