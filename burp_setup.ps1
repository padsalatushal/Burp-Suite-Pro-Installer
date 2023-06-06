# Check for admin 
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Needs to be ran as Administrator. Attempting to relaunch."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -Command `"iwr -useb https://padsalatushal.github.io/burp_setup.ps1 | iex`""

    break
}

# check for execution policy 
$executionPolicy = Get-ExecutionPolicy
if ($executionPolicy -ne "Bypass") {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -Command `"iwr -useb https://padsalatushal.github.io/burp_setup.ps1 | iex`""
    break     
}

<#
# Check if winget is installed or not. if not then it install winget according to system
$wingetInstalled = Get-Command -Name winget -ErrorAction SilentlyContinue
if ($wingetInstalled) {
    Write-Host "winget is already installed on this system."
} else {
    Write-Host "winget is not installed on this system. Installing now..."
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Script -Name winget-install -Force
    winget-install.ps1
        
    # Check if winget is now installed
    $wingetInstalled = Get-Command -Name winget -ErrorAction SilentlyContinue
    if ($wingetInstalled) {
        Write-Host "winget has been successfully installed."
    } else {
        Write-Host "Failed to install winget."
    }
}



# Install java 8 with winget
try {
    winget install -e --id Oracle.JavaRuntimeEnvironment   
}
catch {
    Write-host "Failed to install java 8. Install it Mannually."
}
#>



# Check JRE-8 Availability or Download JRE-8
$jre8 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *"
if (!($jre8)){
    echo "`n`t`tDownloading Java JRE ...."
    wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=248242_ce59cff5c23f4e2eaf4e778a117d4c5b" -O jre-8.exe
    echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
    start -wait jre-8.exe
    rm jre-8.exe
}else{
    echo "`n`nRequired JRE-8 is Installed`n"
    $jre8
}


# Downloading Burp_Suite_Professional_1.7.37 and Burp suite loader
Write-Host "Downloading Burp_Suite_Professional_1.7.37"

$url = "https://portswigger.net/burp/releases/startdownload?product=pro&version=1.7.37&type=Jar"
$folderPath = [Environment]::GetFolderPath('Desktop') + '\Burp_Suite_Professional_1.7.37'
New-Item -ItemType Directory -Force -Path $folderPath
$outputFilePath = Join-Path $folderPath "burpsuite_pro_v1.7.37.jar"
Invoke-WebRequest -Uri $url -OutFile $outputFilePath

# Downloading Burp Loader Keygen
Write-Host "Downloading Burp loader keygen"
$loader_url = "https://github.com/padsalatushal/Burp-Suite-Pro-Installer/raw/main/burp-loader-keygen.jar"
$loader_outputFilePath = Join-Path $folderPath "burp-loader-keygen.jar"
Invoke-WebRequest -Uri $loader_url -OutFile $loader_outputFilePath


# Creating bat file 
$batFilePath = [Environment]::GetFolderPath('Desktop') + '\burp.bat'

if (Test-Path $batFilePath) {
    Remove-Item $batFilePath
}

$batCommands = @"
@echo off
echo Starting Burp Suite...
cd "%USERPROFILE%\Desktop\Burp_Suite_Professional_1.7.37\"
start /B "" "C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe" -jar "%USERPROFILE%\Desktop\Burp_Suite_Professional_1.7.37\burp-loader-keygen.jar"
pause
"@

Set-Content -Path $batFilePath -Value $batCommands