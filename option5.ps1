 #option 5 of menu
 Function Add-ClientInfo{
 
param (
    [parameter(Mandatory=$true)][string]$Firstname,
    [parameter(Mandatory=$true)][string]$Lastname,
    [parameter(Mandatory=$true)][string]$Business,
    [parameter(Mandatory=$true)][string]$Telephone,
    [parameter(Mandatory=$true)][string]$Email
)

Set-StrictMode -version latest

 $database = ".\clientinfo.csv"
 $PathCheck = test-path $database


if ($PathCheck -eq 'True'){

}
else {
Write-Output ("File not Found")
break
}


$AddClient = @(

[pscustomobject]@{
    FirstName = $Firstname;
    Lastname = $Lastname;
    Business = $Business;
    Telephone = $Telephone;
    Email = $Email
} | Export-Csv -Append $database -NoTypeInformation
)

$AddClient = import-CSV $database

$AddClient | Export-Csv -Path $database -NoTypeInformation

Write-host "New Client added" -ForegroundColor DarkGreen -BackgroundColor White
pause

}