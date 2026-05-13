

# Remove-Module New-Result
cls
Write-Host "`n############       Removiendo Modulos  ##################`n "

Remove-Module New-Directory
Remove-Module New-Document
Remove-Module Get-Cpu
Remove-Module Get-Disk
Remove-Module Get-Eqp
Remove-Module Get-FDisk
Remove-Module Get-IpNet
Remove-Module Get-NetAdp
Remove-Module Get-TMZone
Remove-Module Get-HtmlInforme
./Auditoria.ps1


<#
$item = Get-NetAdapter | 
        Select-Object Name, MacAddress, InterfaceDescription, 
        Status, LinkSpeed

$arrayt = {}

foreach($itm in $item.PSObject.Properties){

    # Write-Host $itm.Name
    if($itm.Name -eq "SyncRoot"){
        $asd = ($item.($itm.Name))
        Write-Host $asd
    }

Write-Host $item.PSObject.Properties.SyncRoot
  #              
  #                              [PSCustomObject]@{
  #                                  PROPERTY  = $moduleT.Name
  #                                  VALUE = $moduleT.Value
  #                              }
                            } 


#>