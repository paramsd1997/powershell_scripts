# Get the list of active and inactive users
$activeUsers = Get-ADUser -Filter {Enabled -eq $true} -Properties *
$inactiveUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties *

# Create an HTML file
$outputFile = "C:\users.html"
New-Item $outputFile -ItemType file -Force

# Define the HTML content
$html = @"
<html>
<head>
    <title>Active and Inactive Users</title>
</head>
<body>
    <h1>Active Users</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
        </tr>
"@

# Add the active users to the HTML table
foreach ($user in $activeUsers) {
    $html += "<tr>"
    $html += "<td>$($user.Name)</td>"
    $html += "<td>$($user.EmailAddress)</td>"
    $html += "<td>$($user.Department)</td>"
    $html += "</tr>"
}

# Add the inactive users to the HTML table
$html += @"
    </table>
    <h1>Inactive Users</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
        </tr>
"@
foreach ($user in $inactiveUsers) {
    $html += "<tr>"
    $html += "<td>$($user.Name)</td>"
    $html += "<td>$($user.EmailAddress)</td>"
    $html += "<td>$($user.Department)</td>"
    $html += "</tr>"
}

# Close the HTML table and file
$html += @"
    </table>
</body>
</html>
"@
$html | Out-File $outputFile
