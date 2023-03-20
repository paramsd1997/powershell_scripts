# Retrieve inactive accounts
$inactiveDays = 45
$inactiveDate = (Get-Date).AddDays($inactiveDays)
$inactiveAccounts = Get-ADUser -Filter {LastLogonTimeStamp -lt $inactiveDate -and Enabled -eq $true} -Properties LastLogonTimeStamp | Select-Object Name, SamAccountName, LastLogonTimeStamp

# Retrieve accounts with expired password
$expiredDays = 45
$expiredDate = (Get-Date).AddDays($expiredDays)
$expiredAccounts = Search-ADAccount -AccountExpired -UsersOnly | Where-Object {$_.PasswordLastSet -lt $expiredDate} | Select-Object Name, SamAccountName, PasswordLastSet

# Generate HTML report


$html = @"
<style>
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px;
    }
</style>
<h2>Inactive Accounts</h2>
<table>
    <tr>
        <th>Name</th>
        <th>SamAccountName</th>
        <th>LastLogonTimeStamp</th>
    </tr>
"@
foreach ($account in $inactiveAccounts) {
    $html += "<tr><td>$($account.Name)</td><td>$($account.SamAccountName)</td><td>$($account.LastLogonTimeStamp)</td></tr>"
}
$html += "</table><br><h2>Expired Passwords</h2><table><tr><th>Name</th><th>SamAccountName</th><th>PasswordLastSet</th></tr>"
foreach ($account in $expiredAccounts) {
    $html += "<tr><td>$($account.Name)</td><td>$($account.SamAccountName)</td><td>$($account.PasswordLastSet)</td></tr>"
}
$html += "</table>"

# Send email
$to = "recipient@example.com"
$from = "sender@example.com"
$subject = "Inactive and Expired Accounts Report"
$body = $html
$smtpServer = "smtp.example.com"
$smtpPort = 587
$smtpCredential = New-Object System.Net.NetworkCredential("username", "password")
$smtp = New-Object Net.Mail.SmtpClient($smtpServer, $smtpPort)
$smtp.EnableSsl = $true
$smtp.Credentials = $smtpCredential
$smtp.Send($from, $to, $subject, $body)
