param(
    [string]$path,
    [string]$nameDir
)

$localpath = Get-Location

Import-Module -Name "$localpath\New-Resultjson.psm1"


function New-Directory($path, $nameDir){

    # Validated Parent path
    $path_validated = pathValidator -path $path

    if($path_validated){

        try{

            New-Item -ItemType "Directory" -Path "$path\$nameDir" -ErrorAction Stop -Force | Out-Null 

            $result = New-Resultjson -STATUS 1 -MSG "Directory generated succesfull" -DATA "$path\$nameDir" 

            return $result
            


        }catch{

            $msg = $_.Exception.Message

            $MsjR=@{

                STATUS = 0
                MSG = $msg
                DATA = $null
            }

            return $MsjR | ConvertTo-JSON  
            
        }


    }else{

            $MsjR=@{
                    STATUS = 0
                    MSG = "Has ben an error to read directory path"
                    DATA = $null
            }

            return $MsjR | ConvertTo-JSON  

    }

    

}


function pathValidator($path){

    if((Test-Path -Path $path))
    { 
        return $true
    
    }else{ 
        return $false 
    }

}

Export-ModuleMember New-Directory