 (Get-ADUser -Filter "Name -like '*'").count
 #Get-ADUser "<abhishek>" -Properties LastLogonDate | FT -Property Name, LastLogonDate -A
 Get-ADUser -Filter {(Enabled -eq $true)} -Properties LastLogonDate | select samaccountname, Name, LastLogonDate | Sort-Object LastLogonDate
 (Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ }