

Get-ADUser -Filter * -Properties samAccountName | select samAccountName
New-ADUser -Name "Jackey Robinson" -GivenName "Jackey" -Surname "Robinson" -SamAccountName "J.Robinson" -UserPrincipalName "J.Robinson@enterprise.com" -Path "OU=Managers,DC=enterprise,DC=com" -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true
get-aduser -filter *



# Set the email parameters
$SMTPServer = "office365.com"
$From = "admin@example.com"
$To = "alerts@example.com"
$Subject = "Inactive Accounts and Expired Passwords Report"
$Body = ""

# Get the inactive accounts
$InactiveDays = 90 # Modify this value as needed
$InactiveAccounts = Get-ADUser -Filter {Enabled -eq $true -and LastLogonDate -lt (Get-Date).AddDays(-$InactiveDays)} -Properties LastLogonDate | Select-Object Name, SamAccountName, LastLogonDate

# Get the accounts with expired passwords
$PasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days
$ExpiredAccounts = Search-ADAccount -PasswordExpired -UsersOnly | Select-Object Name, SamAccountName, PasswordLastSet, @{Name="PasswordAge";Expression={(Get-Date) - $_.PasswordLastSet}} | Where-Object {$_.PasswordAge.Days -gt $PasswordAge}

# Add the information to the email body
$Body += "<h2>Inactive Accounts:</h2>"
$Body += ($InactiveAccounts | ConvertTo-Html -As Table -Property Name, SamAccountName, LastLogonDate)

$Body += "<h2>Expired Passwords:</h2>"
$Body += ($ExpiredAccounts | ConvertTo-Html -As Table -Property Name, SamAccountName, PasswordLastSet, PasswordAge)

# Send the email
$Message = New-Object System.Net.Mail.MailMessage $From, $To, $Subject, $Body
$Message.IsBodyHtml = $true
$SMTPClient = New-Object System.Net.Mail.SmtpClient $SMTPServer
$SMTPClient.Send($Message)
