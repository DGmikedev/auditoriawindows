##    Configurations    ########################################

    $date = Get-Date -Format "ddMMyyyy"
    $time = Get-Date -Format "HH:mm:ss"

    # repositry of documents
    $LocalPath = (Get-Location).path

    # Name of respository docs
    $RepoName  = "RepositoryAuditory"

    # log document name
    $LogsName = "Log_auditoria_$date.txt"

    # log html informe
    $htmlIf = "$PSSCriptRoot\Infrastructure\GetInformationHtml\Get-HtmlInforme.psm1"

    # ID EQP
    $IDEQP = 1234567890

### IMPORT MODULES ############################################################

# toDocuments
    Import-Module -Name "$PSSCriptRoot\CommonFunctions\New-Directory.psm1"
    Import-Module -Name "$PSSCriptRoot\CommonFunctions\New-Document.psm1"
    Import-Module -Name "$htmlIf"

    # Gets Hardware Modules
    Import-Module -Name "$PSSCriptRoot\Modules\Get-Cpu.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-Disk.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-Eqp.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-FDisk.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-IpNet.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-NetAdp.psm1"
    Import-Module -Name "$PSSCriptRoot\Modules\Get-TMZone.psm1"

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


### MAIN BLOCK ############################################################################################ 

    $Values = [PSCustomObject]@{}

    $Values | Add-Member -NotePropertyName "ID" -NotePropertyValue  $IDEQP

    $Values | Add-Member -NotePropertyName "DATE" -NotePropertyValue (Get-Date)

    # Repository
    $RepoD = New-Repository -localpath $localpath -RepoName $RepoName

    # Log
    $log = New-Log -LogsName $LogsName -RepoD $RepoD -msg ""

    $Values | Add-Member -NotePropertyName "LOGPATH" -NotePropertyValue $log 

# Log Header
    Add-Content -Path $log -Value "########  AUDITORIA EQP: $IDEQP - FECHA: [ $date | $time ] ##############################"
    Add-Content -Path $log -Value ""
    Add-Content -Path $log -Value "[ $date | $time ] PATH DE MODULOS: "
    Add-Content -Path $log -Value "[ $date | $time ] $PSSCriptRoot\Modules\"
    Add-Content -Path $log -Value ""
    Add-Content -Path $log -Value "[ $date | $time ] LOG: "
    Add-Content -Path $log -Value "[ $date | $time ] $log"
    Add-Content -Path $log -Value ""
    Add-Content -Path $log -Value "[ $date | $time ] MOULO GENERADOR DE HTML DE INFORME: "
    Add-Content -Path $log -Value "[ $date | $time ] $htmlIf"
    Add-Content -Path $log -Value ""
   

## GET DATA HARDWARE ###

    Add-Content -Path $log -Value "MODULOS DE HARDWARE REQUERIDOS"
    Add-Content -Path $log -Value ""

    ## CPU
        $Values | Add-Member -NotePropertyName "CPU" -NotePropertyValue (Get-Cpu -TYPE "raw")

        if($Values.CPU.STATUS -eq 1){

            

            $msg = "Datos de |  CPU  | OK " + "`n   - $PSSCriptRoot\Modules\Get-Cpu.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos de CPU: " + $Values.CPU.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # DISK
        $Values | Add-Member -NotePropertyName "DISK" -NotePropertyValue (Get-Disk -TYPE "raw")
        
        if($Values.DISK.STATUS -eq 1){

            $msg = "Datos de |  PARTICIONES DEL DISCO  | OK " + "`n - $PSSCriptRoot\Modules\Get-Disk.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos de PARTICIONES DEL DISCO: " + $Values.DISK.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # EQP
        $Values | Add-Member -NotePropertyName "EQP" -NotePropertyValue (Get-Eqp -TYPE "raw")
        
        if($Values.EQP.STATUS -eq 1){

            $msg = "Datos de |  EQUIPO  | OK #" + "`n   - $PSSCriptRoot\Modules\Get-Eqp.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos de EQUIPO: " + $Values.EQP.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # Fisical DISK
        $Values | Add-Member -NotePropertyName "FDISK" -NotePropertyValue (Get-FDisk -TYPE "raw")
        
        if($Values.FDISK.STATUS -eq 1){

            $msg = "Datos de |  DISCO FISICO | OK #" + "`n   - $PSSCriptRoot\Modules\Get-FDisk.psm1`n" 

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos del DISCO FISICO: " + $Values.FDISK.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # Ip Net
        $Values | Add-Member -NotePropertyName "IPNET" -NotePropertyValue (Get-IpNet -TYPE "raw")
        
        if($Values.IPNET.STATUS -eq 1){

            $msg = "Datos de |  IP NET  | OK " + "`n   - $PSSCriptRoot\Modules\Get-IpNet.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos de IP Y NET: " + $Values.IPNET.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # ADAPTER NET
        $Values | Add-Member -NotePropertyName "NTADP" -NotePropertyValue (Get-NetAdp -TYPE "raw")
        
        if($Values.NTADP.STATUS -eq 1){

            $msg = "Datos de |  ADAPTADOR DE RED  | OK #" + "`n   - $PSSCriptRoot\Modules\Get-NetAdp.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green


        }else{

            $msg = "Error al conseguir datos de ADAPTADOR DE RED: " + $Values.NTADP.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

    # TIME ZONE
        $Values | Add-Member -NotePropertyName "TMZN" -NotePropertyValue (Get-TMZone -TYPE "raw")
        
        if($Values.TMZN.STATUS -eq 1){

            $msg = "Datos de |  TIME ZONE |  OK " + "`n   - $PSSCriptRoot\Modules\Get-TMZone.psm1`n"

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

        }else{

            
            $msg = "Error al conseguir datos de la TIME ZONE DEL DISCO: " + $Values.TMZN.MSG
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg    -ForegroundColor Green

            Exit 1

        }

Get-HtmlInforme -DATA $Values
Exit 1

