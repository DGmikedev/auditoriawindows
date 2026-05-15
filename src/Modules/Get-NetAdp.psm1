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
<#
        $netAdp = foreach ($adaptador in $net) {

            $hash = @{
                $hash[$adaptador.psobject.properties.Name] = $adaptador.psobject.properties.Name
            }

            Write-Host $adaptador.psobject.properties.Name
            Write-Host ""
            Write-Host $adaptador.MacAddress # psobject.properties.MacAddress
            Write-Host ""
            Write-Host $adaptador.InterfaceDescription
                        Write-Host ""

            #foreach ($propiedad in $adaptador.psobject.properties) {
#
            #    $hash[$propiedad.Name] = $propiedad.Value
            #}
                $hash # Devolver la tabla hash individual al array
        }

        Write-Host ">>>>>>>>>>" $netAdp  #>
        
        #$net.psobject.ImmediateBaseObject 
       
        $Net = New-Result -STATUS 1 -MSG "$PSScriptRoot\Get-NetAdp.psm1" -DATA $net -TYPE $TYPE
        
        return  $Net

    }catch{

        $msg = $_.Exception.Message

        $Net = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

        return $Net

    }
}

Export-ModuleMember Get-NetAdp