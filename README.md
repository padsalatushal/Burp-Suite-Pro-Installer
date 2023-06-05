# Burp-Suite-Pro-Installer

## Description
- This script install Burp Suite Pro v1.7.37
- Activate Burp Suite Pro with Key-Generator and Key-Loader

## Demo


## Launch Command (Powershell) :
```bash
irm https://padsalatushal.github.io/burp_setup.ps1 | iex
```
Or

```bash
iwr -useb https://padsalatushal.github.io/burp_setup.ps1 | iex
```

If you are having TLS 1.2 Issues or You cannot find or resolve host then run with the following command:

```bash
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/padsalatushal/Burp-Suite-Pro-Installer/main/burp_setup.ps1')
```
