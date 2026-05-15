param(
    [PSCustomObject]$DATA
)



function Get-HtmlInforme($DATA){

     # Get HTML Template
    $tmpltpath = Join-Path $PSScriptRoot "\template.html"

    $tmplt = Get-Content $tmpltpath -Raw
    
    # Set ID User-EQUIPMENT
    $tmplt = $tmplt.Replace( "{{ IDEQP }}",  $DATA.ID )
    
    # Get DATA 
    $MODULES = $DATA | Get-Member -MemberType NoteProperty

    # Get Name Modules wihtout  ID, LOGPATH, DATE
    $NameModules = $MODULES | ForEach-Object{ 

        # This 'IF' separe ID, LOGPATH,DATE of $nameModules
        if( !( ($_.Name -eq "ID") -or ($_.Name -eq "LOGPATH") -or ($_.Name -eq "DATE") -or ($_.name -eq "HTMLPATH") ) ){  $_.Name }
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