echo "`n`t`tDownloading Java JRE ...."
Start-BitsTransfer -Source "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=248242_ce59cff5c23f4e2eaf4e778a117d4c5b" -Destination "jre-8.exe"
echo "`n`t`tJRE-8 Downloaded, let's start the Installation process"
Start-Process -Wait -FilePath .\jre-8.exe
Remove-Item .\jre-8.exe
