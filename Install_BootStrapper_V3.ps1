# Set variables
$destinationFolder = "C:\Temp\Liquit\"
$url = "https://download.liquit.com/extra/Bootstrapper/"
$container_url = "https://stliquitprodwe01.blob.core.windows.net/donny/"
$sas_token = "?sp=r&st=2024-06-14T09:08:05Z&se=2029-07-14T17:08:05Z&spr=https&sv=2022-11-02&sr=c&sig=9JEtclBZyNyb%2F6SnnAzOjioaH353c8o1IjPnarZTL6E%3D"

$container = "Azure/"
$strapper = "AgentBootstrapper-Win-2.1.0.2.exe"
$cert = "AgentRegistration.cer"
$agent = "Agent.json"


# Create folder C:\Temp\Liquit 
If (-not (Test-Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory -Force
}

# Download the files
Invoke-WebRequest -Uri ($url + $strapper) -OutFile ($destinationFolder + $strapper)
Invoke-WebRequest -Uri ($container_url + $cert + $sas_token) -OutFile ($destinationFolder + $cert)
Invoke-WebRequest -Uri ($container_url + $container + $agent + $sas_token) -OutFile ($destinationFolder + $agent)

# Install with Liqut Agent BootStrapper
Set-Location $destinationFolder
.\AgentBootstrapper-Win-2.1.0.2.exe /startDeployment /waitForDeployment /logPath=.\Install /certificate=.\AgentRegistration.cer