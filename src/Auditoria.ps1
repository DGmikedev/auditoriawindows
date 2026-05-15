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

# Write log or stop the proccess
    function Write-InLog($Status, $Name, $Data, $log ){

        if($Status -eq 1){

            $msg = "Datos de |  $Name | OK " + " - $Data`n" 

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg -ForegroundColor Green

        }elseif($Status -eq 'F'){
            
            $msg = "$Data`n" 

            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            # Write-Host $msg -ForegroundColor Green

        }else{

            $msg = "Error al conseguir datos del $Name : " + $Data
            
            Add-Content -Path $log -Value "[ $date | $time ] $msg"

            Write-Host $msg -ForegroundColor Red

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
        
        Write-InLog -Status 'F' -Name $null -Data "########  AUDITORIA EQP: $IDEQP - FECHA: [ $date | $time ] ##############################" -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] PATH DE MODULOS: " -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] $PSSCriptRoot\Modules\" -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] LOG: " -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] $log" -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] MOULO GENERADOR DE HTML DE INFORME: " -log $log

        Write-InLog -Status 'F' -Name $null -Data "[ $date | $time ] $htmlIf" -log $log
   
### GET DATA HARDWARE ########

    Add-Content -Path $log -Value "MODULOS DE HARDWARE REQUERIDOS"

    Add-Content -Path $log -Value ""

    # CPU
        $Values | Add-Member -NotePropertyName "CPU" -NotePropertyValue (Get-Cpu -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "CPU" -Data $Values.CPU.MSG -log $log

    # DISK
        $Values | Add-Member -NotePropertyName "DISCO" -NotePropertyValue (Get-Disk -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "DSICO" -Data $Values.DISCO.MSG -log $log
        
    # EQP
        $Values | Add-Member -NotePropertyName "EQUIPO" -NotePropertyValue (Get-Eqp -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "EQUIPO" -Data $Values.EQUIPO.MSG -log $log

    # Fisical DISK
        $Values | Add-Member -NotePropertyName "DISCO_FISICO" -NotePropertyValue (Get-FDisk -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "DISCO_FISICO" -Data $Values.DISCO_FISICO.MSG -log $log

    # Ip Net
        $Values | Add-Member -NotePropertyName "IP_NET" -NotePropertyValue (Get-IpNet -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "IP_NET" -Data $Values.IP_NET.MSG -log $log

    # ADAPTER NET
        $Values | Add-Member -NotePropertyName "ADAPTADOR_NET" -NotePropertyValue (Get-NetAdp -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "ADAPTADOR_NET" -Data $Values.ADAPTADOR_NET.MSG -log $log

    # TIME ZONE
        $Values | Add-Member -NotePropertyName "TIME_ZONE" -NotePropertyValue (Get-TMZone -TYPE "raw")
        Write-InLog -Status $Values.CPU.STATUS -Name "TIME_ZONE" -Data $Values.TIME_ZONE.MSG -log $log

Get-HtmlInforme -DATA $Values

Exit 1

