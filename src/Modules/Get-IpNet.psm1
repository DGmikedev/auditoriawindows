param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"
function Get-IpNet($TYPE){

    try{
        
        $dat1 = Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress
            
        
        $IpNet = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-IpNet.psm1" -DATA $dat1 -TYPE $TYPE
        
        return  $IpNet

    }catch{

        $msg = $_.Exception.Message

        $IpNet = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $IpNet

    }
}

Export-ModuleMember Get-IpNet