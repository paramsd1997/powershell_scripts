Install-Module ImportExcel

Import-Csv “C:\Temp\InactiveUsers12.CSV” | Export-Excel “C:\InactiveUsers123.xlsx”

Get-Content C:\InactiveUsers123.xlsx