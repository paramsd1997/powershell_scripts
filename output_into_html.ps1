# Get inactive accounts
$inactiveAccounts = Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 | Select-Object SamAccountName, LastLogonDate

# Get accounts with expired passwords
$expiredAccounts = Search-ADAccount -PasswordExpired | Select-Object SamAccountName

# Create HTML file
$htmlFile = "C:\Path\To\Output\File.html"
New-Item $htmlFile -ItemType File

# Start HTML output
$htmlOutput = "<html><head><title>Inactive and Expired Password Accounts</title></head><body><h1>Inactive and Expired Password Accounts</h1><table><tr><th>Account Name</th><th>Last Logon Date</th><th>Password Expired</th></tr>"

# Add inactive accounts to HTML output
foreach ($account in $inactiveAccounts) {
    $htmlOutput += "<tr><td>$($account.SamAccountName)</td><td>$($account.LastLogonDate)</td><td></td></tr>"
}

# Add expired accounts to HTML output
foreach ($account in $expiredAccounts) {
    $htmlOutput += "<tr><td>$($account.SamAccountName)</td><td></td><td>Yes</td></tr>"
}

# End HTML output
$htmlOutput += "</table></body></html>"

# Write output to file
