Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}



Get-ADUserResultantPasswordPolicy  parmeshwar.d


Get-ADUser -Identity parmeshwar.d –Properties msDS-UserPasswordExpiryTimeComputed, * | Format-List * -Force;
