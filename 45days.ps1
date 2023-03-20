Search-ADAccount –AccountInActive -UsersOnly –TimeSpan 90:00:00:00 –ResultPageSize 20 –ResultSetSize $null |?{$_.Enabled –eq $True} | Select-Object Name, DistinguishedName| Export-CSV “C:\Temp\InactiveUsers12.CSV” –NoTypeInformation


Get-Content C:\Temp\InactiveUsers12.CSV


$date= (get-date).AddDays(-45)

Get-ADUser-Filter {LastLogonDate-lt $date} -Property Enabled | Where-Object {$_.Enabled -like “true”} | Select-Object Name, DistinguishedName| Export-CSV “C:\Temp\InactiveUsers12.CSV” –NoTypeInformation