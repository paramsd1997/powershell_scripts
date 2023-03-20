## to check the IIS installed or not 
Get-WindowsFeature -Name Web-Server | Select-Object Installed

## IncludeManagementTools parameter installs the IIS management tools as well, which are useful for configuring and managing IIS.

## to install the IIS run the fallowing cmdlet
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

## Select-Object cmdlet is used to filter the output and only show the Installed property, 
## which indicates whether the feature is installed or not.


Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*CrowdStrike*" }

Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*Dynamics *" }


Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like "*rapid7*"}
 Get-Service | Where-Object {$_.Name -eq "rapid7-agent"}

