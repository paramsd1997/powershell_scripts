$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0} `
 -Properties "Name", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed" | ` Select-Object -Property "Name", "EmailAddress", `
 @{Name = "PasswordExpiry"; Expression = {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed").tolongdatestring() }}

 Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like "*rapid7*"}
 Get-Service | Where-Object {$_.Name -eq "rapid7-agent"}
