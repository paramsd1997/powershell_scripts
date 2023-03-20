
$users = Search-ADAccount -UsersOnly -AccountExpiring -TimeSpan 31:0:0:0.0

ForEach($user in $users)
{
    $userobj = $user | Get-ADUser -Properties EmailAddress,AccountExpirationDate

    $options = @{
        'To' = $userobj.EmailAddress
        'From' = 'administrator@testlab.local'
        'Subject' = "Account is Expiring on $($userobj.AccountExpirationDate)"
        'SMTPServer' = 'svr.domain.local'
        'Body' = "Account is Expiring on $($userobj.AccountExpirationDate)"
    }

    Send-MailMessage @options
}

