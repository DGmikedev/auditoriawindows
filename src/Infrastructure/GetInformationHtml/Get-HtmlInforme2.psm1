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

    $DivLateral = ""
    $DivMain = ""


    $modules = $DATA | Get-Member -MemberType NoteProperty


    foreach($module in $modules){
        if(!($module.Name -eq "ID" -or  $module.Name -eq "DATE" -or $module.Name -eq "LOGPATH")){

            #foreach($item in $module.)
            $DivLateral += "<div class=`"menu-item`" onclick=`"showSection('"+ $module.Name.ToLower() + "', this)`">"+  $module.Name +"</div>"

            Write-Host $DATA.($module.Name).DATA

            $SubDiv = ""

            if($DATA.($module.Name).DATA.PSObject.Properties.Name -contains "Count"){


                $SubDiv += "<div id=`""+ $module.Name.ToLower() +"`" class=`"section`"> <h1>"+$module.Name+"</h1> <p>$dataItem</p> </div>"

                $dataItem = $SubDiv | ConvertTo-Html -Fragment
                Write-Host "====="$DATA.($module.Name).DATA.PSObject.Properties.Name

            }

            
        }
    }

        $tmplt = $tmplt.Replace( "{{ lateral_menu }}", $DivLateral )
        # $tmplt = $tmplt.Replace( "{{ main_content }}", $DivMain )
        $tmplt | Set-Content "informHTML.html"
        Invoke-Item "informHTML.html"
        Exit 1

    <#
    $modules | ForEach-Object{

        if(!($_.Name -eq "ID" -or  $_.Name -eq "DATE" -or $_.Name -eq "LOGPATH")){

            # Adding lateral divs menu
            $DivLateral += "<div class=`"menu-item`" onclick=`"showSection('"+ $_.Name.ToLower() + "', this)`">"+  $_.Name +"</div>"

            Write-Host $DATA.($_.Name).PSObject.Properties.Name
            Write-Host "#################" + $DATA[$_.Name]


        } # If ID, DATE, LOGPATH END

        
    } # All Object engine




    $tmplt = $tmplt.Replace( "{{ lateral_menu }}", $DivLateral )
    # $tmplt = $tmplt.Replace( "{{ main_content }}", $DivMain )
    $tmplt | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"

    Exit 1
    

    foreach($module in $modules){

        

        if(!($module.Name -eq "ID" -or  $module.Name -eq "DATE" -or $module.Name -eq "LOGPATH")){

            if($DATA.($module.Name).DATA.PSObject.Properties.Name -contains "Count"){



            }

            #if($HaveObjtsInside){
            #    $DATA.($module.Name) | ForEach-Object{
            #        $nms += $_
            #    }
            #}else{
#
            #}


            # $DATA.($module.Name).DATA.PSObject.Properties.Name | ForEach-Object{
            #     $nms += $_
            # }
            # foreach($name in $DATA.($module.Name).DATA.PSObject.Properties.Name){
            #     $nms += $name
            # }

            # if($nms -contains "Count"){
            #     Write-Host $DATA.($module.Name).DATA.PSObject.Properties.Name + "Tienen COunt"
            # }



            # Adding lateral divs menu
            $DivLateral += "<div class=`"menu-item`" onclick=`"showSection('"+ $module.Name.ToLower() + "', this)`">"+  $module.Name +"</div>"
                
                # Transponse data table
                
                 $item = foreach($moduleT in $DATA.($module.Name).DATA.PSObject.Properties){

                        [PSCustomObject]@{
                            PROPERTY  = $moduleT.Name
                            VALUE = $moduleT.Value
                        }

                }   
                   
                Write-Host "====================================="

                $dataItem = $item | ConvertTo-Html -Fragment

            # Adding divs of main content
            $DivMain += "<div id=`""+ $module.Name.ToLower() +"`" class=`"section`"> <h1>"+$module.Name+"</h1> <p>$dataItem</p> </div>"

        }
    }

    <# Get the names of Modules from PSCustomObject 
    foreach($item in $Data){

        # "ID" "DATE" "LOGPATH No data modules
        if(!($item.psobject.properties.name -eq "ID" -or  $item.psobject.properties.name -eq "DATE" -or $item.psobject.properties.name -eq "LOGPATH")){

            # Adding lateral divs menu
            $DivLateral += "<div class=`"menu-item`" onclick=`"showSection('"+ $item.psobject.properties.name.ToLower() + "', this)`">"+  $item.psobject.properties.name +"</div>"





            # Adding divs of main content
            $DivMain += "<div id=`""+ $item.psobject.properties.name.ToLower() +"`" class=`"section`"> <h1>"+$item.psobject.properties.name+"</h1> <p>  </p> </div>"

        }
       
    } #>

    
    <#
    <div id="configuracion" class="section">
            <h1>Configuración</h1>
            <p>
                Opciones generales del sistema.
            </p>
        </div>
    


    $tmplt = $tmplt.Replace( "{{ lateral_menu }}", $DivLateral )
    $tmplt = $tmplt.Replace( "{{ main_content }}", $DivMain )





    $tmplt | Set-Content "informHTML.html"

    Invoke-Item "informHTML.html"




    <#  
    <div class="menu-item" onclick="showSection('configuracion', this)">
            Configuración
        </div>
    #>



    

    
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