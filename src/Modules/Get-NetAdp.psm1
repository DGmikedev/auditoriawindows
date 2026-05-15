param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"
function Get-NetAdp($TYPE){

    try{
        
        $net = Get-NetAdapter | 
        Select-Object Name, 
        MacAddress, 
        InterfaceDescription, 
        Status, 
        LinkSpeed
       
        $Net = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-NetAdp.psm1" -DATA $net -TYPE $TYPE
        
        return  $Net

    }catch{

        $msg = $_.Exception.Message

        $Net = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $Net

    }
}

Export-ModuleMember Get-NetAdp