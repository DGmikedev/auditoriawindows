##    Configurations    ########################################

$date = Get-Date -Format "ddMMyyyy"
$time = Get-Date -Format "HH:mm:ss"

# repositry of documents
$LocalPath = (Get-Location).path

# Name of respository docs
$RepoName  = "RepositoryAuditory"

# log document name
$LogsName = "Log_auditoria_$date.txt"

###############################################################

$html = "<h1>Hola mundo</h1>"
$path = "$env:TEMP\test.html"

$html | Set-Content $path
Start-Process $path


Import-Module -Name "$localpath\CommonFunctions\New-Directory.psm1"

New-Directory -path $localpath -nameDir $RepoName