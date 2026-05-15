param(
    [string]$TYPE = "raw"
)

$RJson = Join-Path (Split-Path $PSScriptRoot -Parent) "\CommonFunctions\New-Result.psm1"

Import-Module "$RJson"
function Get-Eqp($TYPE){

    try{
        
        $eqp = Get-ComputerInfo | 
        Select-Object WindowsInstallDateFromRegistry, 
        WindowsProductName, 
        WindowsRegisteredOwner, 
        WindowsSystemRoot, 
        BiosName, 
        CsDNSHostName, 
        CsDomain, 
        CsName, 
        CsSystemType, 
        CsUserName,
        CsWorkgroup, 
        OsOperatingSystemSKU, 
        OsVersion,
        OsSystemDirectory, 
        OsSystemDrive, 
        OsWindowsDirectory,
        OsManufacturer, 
        OsLanguage, 
        TimeZone

        $REqp = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-Eqp.psm1" -DATA $eqp -TYPE $TYPE
        
        return  $REqp

    }catch{

        $msg = $_.Exception.Message

        $REqp = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $REqp

    }
}

Export-ModuleMember Get-Eqp
