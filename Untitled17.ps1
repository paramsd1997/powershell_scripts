get-aduser -filter * -properties passwordlastset, passwordneverexpires |ft Name, passwordlastset, Passwordneverexpires | Export-Csv "C:\Drive2"
Search-ADAccount -PasswordNeverExpires | FT Name,ObjectCkass -A
Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}