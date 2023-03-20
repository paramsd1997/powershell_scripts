Import-Module ActiveDirectory

#Create warning dates for future password expiration

$SevenDayWarnDate = (get-date).adddays(2).ToLongDateString()

#Email Variables

$MailSender = " parmeshwar.1@globallogic.com"
$Subject = 'FYI - Your account password will expire soon'
$EmailStub1 = ' I am here to inform you that the password for'
$EmailStub2 = 'will expire in'
$EmailStub3 = 'days on'
$EmailStub4 = '. Please contact the helpdesk if you need assistance changing your password. DO NOT REPLY TO THIS EMAIL.'
$SMTPServer = 'smtp.gmail.com'



#Find accounts that are enabled and have expiring passwords



$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0 } `
 -Properties "Name", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Name", "EmailAddress", `
 @{Name = "PasswordExpiry"; Expression = {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed").tolongdatestring() }}

#check password expiration date and send email on match

foreach ($user in $users) {
     if ($user.PasswordExpiry -eq $SevenDayWarnDate) {
         $days = 2
         $EmailBody = $EmailStub1, $user.name, $EmailStub2, $days, $EmailStub3, $SevenDayWarnDate, $EmailStub4 -join ' '

         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody
     }
    else {}
 }