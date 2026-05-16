param(
    [PSCustomObject]$DATA
)



function Get-HtmlInforme($DATA){

     # Get HTML Template
    $tmpltpath   = Join-Path $PSScriptRoot "\template.html"

    $tmplt = Get-Content $tmpltpath -Raw

    $tmplttrjeta = Join-Path $PSScriptRoot "\tarjeta.html"

    $tmpltTarjeta = Get-Content $tmplttrjeta -Raw

    <#
 # {NoEmpleado:2345678;NoCENTRO:62351;234323}
    GERENTE = @{
        NUMERO_EMPL = 15487123
        CENTRO = 159263
        ACEPTACION = 1
        CELLO = "8945922a0e49573c4aa8b5abd4a35069"

    }


                      EMPL_ACARGO = @{
                              
                              
   
   
   
   
   
   
   
    #>
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ LABEL }}", $DATA.EQUIPO_R.LABEL)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ CENTRO DEL EQUIPO }}", $DATA.EQUIPO_R.CENTRO_EQ )
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ DIRECCION CENTRO }}", $DATA.EQUIPO_R.CENTRO_DIRECCION)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ TELEFONO CENTRO }}", $DATA.EQUIPO_R.TELEFONO_CENTRO)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ NUMERO SHELL }}", $DATA.EQUIPO_R.NUMERO_SHELL)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ NOMBRE SHELL }}", $DATA.EQUIPO_R.NOMBRE_SHELL)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ ROOM }}", $DATA.EQUIPO_R.ROOM)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ RACK }}", $DATA.EQUIPO_R.RACK)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ UNIDAD }}", $DATA.EQUIPO_R.UNIDAD)

    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ EMPLEADO }}", $DATA.EMPL_ACARGO.EMPLEADO) 
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ CENTRO }}",   $DATA.EMPL_ACARGO.CENTRO)

    
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ NUMERO_EMPL }}", $DATA.GERENTE.NUMERO_EMPL)
    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ CENTRO }}", $DATA.GERENTE.CENTRO)
    
    
    if($DATA.GERENTE.ACEPTACION){
        $acp = "color:green; font-weight: bold;" 
    }else{
        $acp = "color:red"
    }

    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ ACEPTACION }}", $acp)

    $tmpltTarjeta = $tmpltTarjeta.Replace( "{{ CELLO }}", $DATA.GERENTE.CELLO)

    

    # Set ID User-EQUIPMENT
    $tmplt = $tmplt.Replace( "{{ IDEQP }}",  $DATA.ID )
    
    $tmplt = $tmplt.Replace("{{ tarjeta }}", $tmpltTarjeta)


    
    

    



   
    
    # Get DATA 
    $MODULES = $DATA | Get-Member -MemberType NoteProperty

    # Get Name Modules wihtout  ID, LOGPATH, DATE
    $NameModules = $MODULES | ForEach-Object{ 

        # This 'IF' separe ID, LOGPATH, DATE, HTMLPATH, EQUIPO_R, EMPL_ACARGO, GERENTE of $nameModules
        if( !( 
                ($_.Name -eq "ID") -or 
                ($_.Name -eq "LOGPATH") -or 
                ($_.Name -eq "DATE") -or 
                ($_.name -eq "HTMLPATH") -or 
                ($_.Name -eq "EQUIPO_R") -or 
                ($_.Name -eq "EMPL_ACARGO") -or
                ($_.Name -eq "GERENTE")
            ) 
        )
        {  
            $_.Name 
        }
    }

    # This foreach separate Mudules with 'Count' property 
    # and apply the insert in the array of conatent html
    foreach($name in $NameModules){

        # SET Divs of lateral menu
        $DivLateral += "<div class=`"menu-item`" onclick=`"showSection('"+ $name.ToLower() + "', this)`">"+  $name +"</div>"


        # Get Modules with Count property
        if($DATA.($name).DATA.psobject.properties.Name -contains "Count"){
        
            $dataItem = $DATA.($name).DATA | ConvertTo-HTML -Fragment 

            $DivMain += "<div id=`""+ $name.ToLower() +"`" class=`"section`"> <h1>"+$name+"</h1> <p>$dataItem</p> </div>"

        }else{

               # Transponse data table
                
                 $item = foreach($moduleT in $DATA.($name).DATA.PSObject.Properties){

                        [PSCustomObject]@{

                            PROPERTY  = $moduleT.Name

                            VALUE = $moduleT.Value

                        }

                }   

                $dataItem = $item | ConvertTo-Html -Fragment 

            # Adding divs of main content
            $DivMain += "<div id=`""+ $name.ToLower() +"`" class=`"section`"> <h1>"+$name.Name+"</h1> <p>$dataItem</p> </div>"

        }
    
    }

    $tmplt = $tmplt.Replace( "{{ lateral_menu }}", $DivLateral )
    $tmplt = $tmplt.Replace( "{{ main_content }}", $DivMain )
    $tmplt | Set-Content $DATA.HTMLPATH
    Invoke-Item $DATA.HTMLPATH

}

Export-moduleMember Get-HtmlInforme