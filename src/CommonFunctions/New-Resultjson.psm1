param(
    [int]   $STATUS,
    [string]$MSG,
    [string]$DATA
    
)

function New-Resultjson($STATUS ,$MSG ,$DATA){
    $RObjc=@{
                STATUS = $STATUS
                MSG    = $MSG
                DATA   = $DATA
            }
    return $RObjc | ConvertTo-JSON 

}

Export-ModuleMember New-Resultjson

