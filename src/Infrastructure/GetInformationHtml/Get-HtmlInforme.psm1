param(
    [PSCustomObject]$DATA
)

$ScrPath  = Split-Path ( Split-Path $PSScriptRoot -Parent) -Parent

function Get-HtmlInforme($DATA){

    

    # Get HTML Template
    $tmpltpath = Join-Path $PSScriptRoot "\template.html"

    $tmplt = Get-Content $tmpltpath -Raw
    
    # Set ID User-EQUIPMENT
    $tmplt = $tmplt.Replace( "{{ IDEQP }}",  $DATA.ID )

    $OpcNames = New-Object System.Collections.Generic.List[string]

    $menuLtrl = ""

    foreach($item in $DATA){

        $item.PSObject.Properties.Name

        $html = '<div class="menu-item" onclick="showSection(''configuracion'', this)"> ' + $TMPN + ' </div>' + "`n"
        
        $OpcNames.Add($html)

        $TMPN = ""

    }

    Write-Host $OpcNames

    $tmplt = $tmplt.Replace( "{{ lateral_menu }}", $menuLtrl )




    <#  
    <div class="menu-item" onclick="showSection('configuracion', this)">
            Configuración
        </div>
    #>



    $tmplt | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"

    
#
    #
#
    #


    #{{ IDEQP }}
    #Write-Host  $DATA | ConvertTo-JSON
}


Export-moduleMember Get-HtmlInforme
<#
# Datos de reporte
 $IDEQP = 1234567890





# Paths of modules
    $CpuMod = Join-Path $ScrPath "\Modules\Get-Cpu.psm1"

# Import Modules
    Import-Module $CpuMod



# Use of function GET

    
    $cpu = Get-Cpu -TYPE "raw"

    # Transponse cpu data table
    $tablaCPU = foreach($cpu in $cpu.DATA.PSObject.Properties){

                    [PSCustomObject]@{
                        PROPERTY  = $cpu.Name
                        VALUE = $cpu.Value
                    }
                }
    
    $cpuTbl = $cpuTbl.Replace(

        "{{ CPU_TABLE }}",

        ( $tablaCPU | ConvertTo-Html -Fragment )

    )

    $cpuTbl | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"

Exit 1
#>