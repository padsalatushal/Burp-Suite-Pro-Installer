# Check if winget is installed or not. if not then it install winget according to system

$wingetInstalled = Get-Command -Name winget -ErrorAction SilentlyContinue
if ($wingetInstalled) {
    Write-Host "winget is already installed on this system."
} else {
    Write-Host "winget is not installed on this system. Installing now..."

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



# install java 8 
try {
    winget install -e --id Oracle.JavaRuntimeEnvironment   
}
catch {
    Write-host "Failed to install java 8. Install it Mannually."
}

# Downloading Burp_Suite_Professional_1.7.37 and Burp suite loader
Write-Host "Downloading Burp_Suite_Professional_1.7.37"

$url = "https://portswigger.net/burp/releases/startdownload?product=pro&version=1.7.37&type=Jar"
$folderPath = [Environment]::GetFolderPath('Desktop') + '\Burp_Suite_Professional_1.7.37'
New-Item -ItemType Directory -Force -Path $folderPath
$outputFilePath = Join-Path $folderPath "burpsuite_pro_v1.7.37.jar"
Invoke-WebRequest -Uri $url -OutFile $outputFilePath

# Downloading Loader 
Write-Host "Downloading burp-loader-keygen.jar"
$loader_url = "https://github.com/padsalatushal/Burp-Suite-Pro-Installer/raw/main/burp-loader-keygen.jar"
$loader_outputFilePath = Join-Path $folderPath "burp-loader-keygen.jar"
Invoke-WebRequest -Uri $loader_url -OutFile $loader_outputFilePath


# creating bat file 
$batFilePath = [Environment]::GetFolderPath('Desktop') + '\burp.bat'

if (Test-Path $batFilePath) {
    Remove-Item $batFilePath
}

$batCommands = @"
@echo off
echo Starting Burp Suite...
"C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe" -jar %USERPROFILE%\Desktop\Burp_Suite_Professional_1.7.37\burp-loader-keygen.jar &
"@

Set-Content -Path $batFilePath -Value $batCommands
