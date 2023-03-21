# Define the number of days after which an account is considered inactive
$inactiveDays = 90

# Get all user accounts from Active Directory
$users = Get-ADUser -Filter * -Properties LastLogonTimestamp, PasswordLastSet

# Create an empty array to store inactive and expired accounts
$report = @()

# Loop through each user account and check if it is inactive or has an expired password
foreach ($user in $users) {
    # Calculate the number of days since the user last logged on
    $lastLogon = $user.LastLogonTimestamp
    if ($lastLogon -eq $null) {
        $lastLogon = $user.PasswordLastSet
    }
    $daysSinceLastLogon = (Get-Date) - $lastLogon
    if ($daysSinceLastLogon.Days -gt $inactiveDays) {
        # Add the inactive account to the report
        $report += [PSCustomObject]@{
            Name = $user.Name
            LastLogon = $lastLogon
            DaysInactive = $daysSinceLastLogon.Days
            Status = "Inactive"
        }
    }

    # Check if the user's password has expired
    $passwordLastSet = $user.PasswordLastSet
    $passwordAge = (Get-Date) - $passwordLastSet
    $maxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge
    if ($passwordAge.Days -gt $maxPasswordAge.Days) {
        # Add the expired password account to the report
        $report += [PSCustomObject]@{
            Name = $user.Name
            PasswordLastSet = $passwordLastSet
            PasswordAge = $passwordAge.Days
            MaxPasswordAge = $maxPasswordAge.Days
            Status = "Password expired"
        }
    }
}

# Generate an HTML report
$html = "<html><head><style>"
$html += "table {border-collapse: collapse;}"
$html += "table, th, td {border: 1px solid black;}"
$html += "th, td {padding: 5px;}"
$html += "th {background-color: #ddd;}"
$html += "tr.Inactive td {background-color: #ffcccc;}"
$html += "tr.[Password expired] td {background-color: #ffffcc;}"
$html += "</style></head><body>"
$html += "<h1>Account Status Report</h1>"
$html += "<table><tr><th>Name</th><th>Status</th><th>Last Logon</th><th>Days Inactive</th><th>Password Last Set</th><th>Password Age</th><th>Max Password Age</th></tr>"
foreach ($row in $report) {
    $html += "<tr class='$($row.Status)'>"
    $html += "<td>$($row.Name)</td>"
    $html += "<td>$($row.Status)</td>"
    $html += "<td>$($row.LastLogon)</td>"
    $html += "<td>$($row.DaysInactive)</td>"
    $html += "<td>$($row.PasswordLastSet)</td>"
    $html += "<td>$($row.PasswordAge)</td>"
    $html += "<td>$($row.MaxPasswordAge)</td>"
    $html += "</tr>"
}
$html += "</table></body></html>"

# Save the HTML report to a file
$html | Out-File -FilePath "C:\Path\To\Report
