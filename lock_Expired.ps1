##Below command will filter all user accounts for the PasswordNeverExpires attribute and display only the users that are set to true.

Search-ADAccount -PasswordNeverExpires 

## Below command will filter all blocked account 
Search-ADAccount -LockedOut

get-aduser -filter * -properties Name, PasswordNeverExpires | where {
$_.passwordNeverExpires -eq "true" }