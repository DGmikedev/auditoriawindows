##    Configurations    ########################################

$date = Get-Date -Format "ddMMyyyy"
$time = Get-Date -Format "HH:mm:ss"

# repositry of documents
$LocalPath = (Get-Location).path

# Name of respository docs
$RepoName  = "RepositoryAuditory"

# log document name
$LogsName = "Log_auditoria_$date.txt"

# ID EQP
$IDEQP = 1234567890



### IMPORT MODULES ############################################################


Import-Module -Name "$PSSCriptRoot\CommonFunctions\New-Directory.psm1"
Import-Module -Name "$PSSCriptRoot\CommonFunctions\New-Document.psm1"




### FUNCTIONS ################################################################

# Make repository of documents
function New-Repository($localpath, $RepoName){
    
    $Repo = New-Directory -path $localpath -nameDir $RepoName -TYPE "raw"

    if( $Repo.STATUS -eq 1){
        
        Write-Host "Exito al crear el rpositorio: "$Repo.DATA    -ForegroundColor Green

        return $Repo.DATA

    }else{

        Write-Host "Problemas al crear el rpositorio: "$Repo.MSG    -ForegroundColor Red

        Exit 1
    }
}


# Make log of document
function New-Log($LogsName, $RepoD, $msg){
    
    $log = New-Document -name $LogsName -path $RepoD -value $msg  -TYPE "raw"

    if( $log.STATUS -eq 1){

        Write-Host "Exito al crear el Docuemnto LOG: " $log.DATA    -ForegroundColor Green

        return $log.DATA

    }elseif( $log.STATUS -eq 2){
        
        Write-Host "Documento log ya había sido creado: " $log.DATA    -ForegroundColor Green

        return $log.DATA

    }else{

        Write-Host "Problemas al crear el Docuemnto LOG: "$log.MSG    -ForegroundColor Red

        Exit 1
    }
}


### BLOCK SCRIPT CREATION ################################################################# 

$Values = [PSCustomObject]@{}

# Repository
$RepoD = New-Repository -localpath $localpath -RepoName $RepoName

# Log
# Log Header

$log = New-Log -LogsName $LogsName -RepoD $RepoD -msg ""

$Values | Add-Member -NotePropertyName "LOGPATH" -NotePropertyValue $log 

Add-Content -Path $log -Value "########  AUDITORIA EQP: $IDEQP - FECHA: [ $date | $time ] ##############################"
Add-Content -Path $log -Value ""
Add-Content -Path $log -Value "[ $date | $time ] LOG - $log"

$Values | Add-Member -NotePropertyName "DATE" -NotePropertyValue Get-Date 



Write-Host $Values


Exit 1

Write-Host "Mdule"