### Gets the current date.
$today = Get-Date

## Gets the maximum password age from the default domain password policy.
$maxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

## Calculates the expiration date before which passwords must be changed to be within 45 days.
$expiresBefore = $today.AddDays($maxPasswordAge.TotalDays - 45)


Get-ADUser -Filter {Enabled -eq $false -and PasswordNeverExpires -eq $false -and PasswordLastSet -gt 0} -Properties PasswordLastSet, PasswordExpired, EmailAddress, DisplayName, SamAccountName, PasswordNeverExpires, PasswordExpired, PasswordNeverExpires, PasswordNotRequired | Where-Object { $_.PasswordExpired -eq $false -and $_.PasswordLastSet.AddDays($maxPasswordAge.TotalDays) -le $expiresBefore } 