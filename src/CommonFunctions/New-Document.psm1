param(
    [string]$name,
    [string]$path,
    [string]$value,
    [string]$TYPE
)

Import-Module "$PSSCriptRoot\New-Result.psm1"


# New-Document -name -path -value -TYPE

function New-Document($name, $path, $value, $TYPE){

    # Test if the docuemnt log already
    $pathd = Join-Path $path $name  

    if(-not(Test-Path $pathd) ){

        if ( pathValidator($path) )
        {
            try{

                New-Item -ItemType "File" -Name $name -Path $path -Value $value -ErrorAction Stop | Out-Null 

                $doc = New-Result -STATUS 1 -MSG "Document Was Created Succefull" -DATA "$pathd" -TYPE $TYPE

                return $doc

            }catch{

                $msg = $_.Exception.Message

                $doc = New-Result -STATUS 0 -MSG $msg -DATA $null -TYPE $TYPE

                return $doc
            }
        }else{

            $doc = New-Result -STATUS 0 -MSG "Has ben an error to read document directory" -DATA $null -TYPE $TYPE

            return $doc
        }

    }else{

        $doc = New-Result -STATUS 2 -MSG "Document was previusly " -DATA "$pathd" -TYPE $TYPE

        return $doc
    }

} # end function 


function pathValidator($path){

    if((Test-Path -Path $path))
    { 
        return $true
    
    }else{ 

        return $false 
    }

}

Export-ModuleMember New-Document