$Password = Read-Host -AsSecureString
New-LocalUser "Barak" -Password $Password -FullName "Obama" -Description "USA Presint"
