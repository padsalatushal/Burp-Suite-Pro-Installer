$validOptions = "1", "2"
$test = ""

while ($test -eq "") {
    Write-Host "Choose an option:"
    Write-Host "1. Burp Suite Pro latest (2022.12.2)"
    Write-Host "2. Burp Suite Pro old (1.7.37)"

    $input = Read-Host "Enter your choice"

    if ($validOptions -contains $input) {
        $test = $input
    } else {
        Write-Host "Invalid option. Please choose a valid option."
    }
}

switch ($test) {
    "1" { $test = "2022.12.2" }
    "2" { $test = "1.7.37" }
}

Write-Host "Selected option: $test"

if ($test -eq "2022.12.2") {
    $url = "https://portswigger.net/burp/releases/startdownload?product=pro&version=2022.12.2&type=Jar"
    $folderPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\Burp_Suite_Professional_2022.12.2"

    # Create the directory if it does not exist
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Force -Path $folderPath
    }

    $outputFilePath = Join-Path $folderPath "burpsuite_pro_v2022.12.2.jar"

    # Remove existing file if it exists
    if (Test-Path $outputFilePath) {
        Write-Host "Deleting Existing File"
        Remove-Item $outputFilePath -Force
    }

    Write-Host "Downloading Burp Suite Pro latest (2022.12.2)"
    Start-BitsTransfer -Source $url -Destination $outputFilePath
}
elseif ($test -eq "1.7.37") {
    $url = "https://portswigger.net/burp/releases/startdownload?product=pro&version=1.7.37&type=Jar"
    $folderPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\Burp_Suite_Professional_1.7.37"

    # Create the directory if it does not exist
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Force -Path $folderPath
    }

    $outputFilePath = Join-Path $folderPath "burpsuite_pro_v1.7.37.jar"

    # Remove existing file if it exists
    if (Test-Path $outputFilePath) {
        Write-Host "Deleting Existing File"
        Remove-Item $outputFilePath -Force
    }

    Write-Host "Downloading Burp Suite Pro old (1.7.37)"
    Start-BitsTransfer -Source $url -Destination $outputFilePath
}
