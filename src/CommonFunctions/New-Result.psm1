param(
    [int]   $STATUS,
    [string]$MSG,
    [string]$DATA,
    [string]$TYPE
    
)

#  New-Resultjson -STATUS -MSG -DATA -TYPE

function New-Result($STATUS ,$MSG ,$DATA, $TYPE){

    $RObjc=@{
                STATUS = $STATUS
                MSG    = $MSG
                DATA   = $DATA
            }

    if($TYPE -eq "json")
    {
        return $RObjc | ConvertTo-JSON 

    }elseif($TYPE -eq "raw")
    {
        return $RObjc

    }else{

        $RObjc=@{

                STATUS = 0
                MSG    = "Error in Result Module -select a valid format: raw, json"
                DATA   = $null
            }
        return $RObjc 
    }
    

}

Export-ModuleMember New-Result

