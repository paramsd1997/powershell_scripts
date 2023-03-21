# New-Item -ItemType File -Path "C:\Path\To\Your\File.html
Set-Content -Path "C:\Path\To\Your\File.html" -Value @"
<!DOCTYPE html>
<html>
<head>
<title>Hello, world!</title>
</head>
<body>
<h1>Hello, world!</h1>
</body>
</html>
"@
