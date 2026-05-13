param(
    [string]$TYPE
)

$mdl = Split-Path $PSSCriptRoot -Parent

Import-Module "$mdl\CommonFunctions\New-Result.psm1"

function Get-TMZone($TYPE){

    try{

        $TMZ = Get-TimeZone | Select-Object Id, DisplayName, StandardName, DaylightName

        $RTmz = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-TMZone.psm1" -DATA $TMZ -TYPE $TYPE

        return $RTmz

    }catch{

        $msg = $_.Exception.Message

        $RTmz = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $RTmz

    }
}

Export-ModuleMember Get-TMZone