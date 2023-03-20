## Identify all active accounts with username, first name, last name, email id

Get-ADUser -Filter {Enabled -eq $true} -Properties GivenName, Surname, EmailAddress 

## Identify all inactive accounts!

Get-ADUser -Filter {Enabled -eq $false} -Properties GivenName, Surname, EmailAddress | Select-Object GivenName, Surname, EmailAddress | Export-Csv -Path "C:\InactiveUsers1.csv"  
