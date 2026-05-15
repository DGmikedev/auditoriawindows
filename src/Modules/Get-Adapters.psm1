param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"
function Get-Adapters($TYPE){

    try{

        $adptrs = Get-NetIPConfiguration | Select-Object  InterfaceDescription

        $Adps = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-Cpu.psm1" -DATA $adptrs -TYPE $TYPE

        return  $Adps

    }catch{

        $msg = $_.Exception.Message

        $Adps = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $Adps

    }

}

Export-ModuleMember Get-Adapters