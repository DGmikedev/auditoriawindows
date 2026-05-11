param(
    [string]$path,
    [string]$nameDir,
    [string]$TYPE
)

$localpath = Get-Location



Import-Module -Name "$PSScriptRoot\New-Result.psm1"


function New-Directory($path, $nameDir, $TYPE){

    # Validated Parent path
    $path_validated = pathValidator -path $path

    if($path_validated){

        try{

            New-Item -ItemType "Directory" -Path "$path\$nameDir" -ErrorAction Stop -Force | Out-Null  

            $result = New-Result -STATUS 1 -MSG "Directory generated succesfull" -DATA "$path\$nameDir"  -TYPE $TYPE

            return $result

        }catch{

            $msg = $_.Exception.Message

            $result = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

            return $result
           
        }

    }else{

        $result = New-Result -STATUS 0 -MSG "Has ben an error to read directory path" -DATA $null -TYPE $TYPE

        return $result

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