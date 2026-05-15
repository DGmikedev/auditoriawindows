param(
    [PSCustomObject]$DATA
)



function Get-HtmlInforme($DATA){
    
    $MODULES = $DATA | Get-Member -MemberType NoteProperty

    # Get Modules Names wihtout  ID, LOGPATH, DATE
    $NamesModules = $MODULES | ForEach-Object{ 
        if( !( ($_.Name -eq "ID") -or ($_.Name -eq "LOGPATH") -or ($_.Name -eq "DATE") ) ){
            $_
        }
    }

    # This foreach separate Mudules with 'Count' property 
    foreach($name in $NamesModules){



        # Get Modules with Count property
        if($DATA.($name).DATA.psobject.properties.Name -contains "Count"){
            Write-Host $name " has Count property"
        }else{
            Write-Host $name " has,n Count property"
        }
    
    }
  


    Write-Host $NamesModules
    #Write-Host $NamesValues


    

}

Export-moduleMember Get-HtmlInforme