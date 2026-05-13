param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"
function Get-FDisk($TYPE){

    try{
        
       $disk =  Get-CimInstance Win32_DiskDrive | 
        Select-Object Caption, partitions, 
        Size, Model

        $RFDisk = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-Fdisk.psm1" -DATA $disk -TYPE $TYPE
        
        return  $RFDisk

    }catch{

        $msg = $_.Exception.Message

        $RFDisk = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $RFDisk

    }
}

Export-ModuleMember Get-FDisk