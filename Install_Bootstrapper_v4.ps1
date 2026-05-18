# Set variables
$destinationFolder = "C:\Temp\Liquit\"
$url = "https://download.liquit.com/extra/Bootstrapper/"
$container_url = "https://stliquitprodwe01.blob.core.windows.net/donny/"
$sas_token = "?sp=r&st=2025-01-08T15:26:30Z&se=2026-12-31T23:26:30Z&spr=https&sv=2022-11-02&sr=c&sig=YJjupGG%2BqaXXhvQ10erGrHG3Dm8XaVEaE80bNHUOl0o%3D"

$container = "AVD/"
$strapper = "AgentBootstrapper-Win-4.4.4130.3708.exe"
$cert = "AgentRegistration.cer"
$agent = "Agent.json"

# Create folder C:\Temp\Liquit 
If (-not (Test-Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory -Force
}

# Download the files
Invoke-WebRequest -Uri ($url + $strapper) -OutFile ($destinationFolder + $strapper)
Invoke-WebRequest -Uri ($container_url + $container + $cert + $sas_token) -OutFile ($destinationFolder + $cert)
Invoke-WebRequest -Uri ($container_url + $container + $agent + $sas_token) -OutFile ($destinationFolder + $agent)

# Install with Liqut Agent BootStrapper
Set-Location $destinationFolder
.\AgentBootstrapper-Win-4.4.4130.3708.exe --zone "https://donny.liquit.com/" --registrationType Certificate --logPath ".\Install" --wait --certificate ".\AgentRegistration.cer" --startDeployment





