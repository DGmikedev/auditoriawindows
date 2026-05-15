

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

Write-Host $item.psobject.ImmediateBaseObject

<#


@{
Name=Ethernet; MacAddress=FC-4D-D4-D2-4A-53; InterfaceDescription=Intel(R) Ethernet 
                  Connection I217-LM; Status=Disconnected; LinkSpeed=0 bps}, 
@{
Name=Wi-Fi; 
                  MacAddress=00-EB-D8-0A-11-B8; InterfaceDescription=Realtek RTL8192EU Wireless LAN 802.11n 
                  USB 2.0 Network Adapter; Status=Up; LinkSpeed=130 Mbps}, 
@{
Name=Ethernet 2; 
                  MacAddress=0A-00-27-00-00-06; InterfaceDescription=VirtualBox Host-Only Ethernet Adapter; 
                  Status=Up; LinkSpeed=1 Gbps}







psobject {
Members, 
Properties, 
Methods, 
ImmediateBaseObject, 
BaseObject, 
TypeNames, 
get_Members, 
get_Properties, 
get_Methods, 
get_ImmediateBaseObject, 
get_BaseObject, 
ToString, 
Copy, 
Equals, 
GetHashCode, 
get_TypeNames, 
CompareTo, 
GetObjectData, 
GetType, 
GetMetaObject}




@{
    Name=Ethernet; 
    MacAddress=FC-4D-D4-D2-4A-53; 
    InterfaceDescription=Intel(R) Ethernet Connection I217-LM; 
    Status=Disconnected; 
    LinkSpeed=0 bps
} 
@{  Name=Wi-Fi; 
    MacAddress=00-EB-D8-0A-11-B8; 
    InterfaceDescription=Realtek RTL8192EU Wireless LAN 802.11n USB 2.0 Network Adapter; 
    Status=Up; 
    LinkSpeed=130 Mbps
} 
@{
    Name=Ethernet 2; 
    MacAddress=0A-00-27-00-00-06; 
    InterfaceDescription=VirtualBox Host-Only Ethernet Adapter; 
    Status=Up; 
    LinkSpeed=1 Gbps
}


<#

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