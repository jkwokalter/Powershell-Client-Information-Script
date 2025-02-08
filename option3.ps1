<#option 3 
A basic procedure in database management is the ability to update client information. 
Database's are never static, people move, get married, companies go under, or change name. 
Editing a database is a daily activity.
#>


<#Param(
[Parameter(Mandatory=$true)][string]$fname,
[Parameter(Mandatory=$true)][string]$lname,
[Parameter(Mandatory=$true)][string]$Business,
[Parameter(Mandatory=$true)][string]$Telephone,
[Parameter(Mandatory=$true)][string]$Email
)
Set-StrictMode -Version Latest #>


#Test if the path to the database file exists and if not exit with a message
$filepath = ".\clientinfo.csv"
$testpath = Test-Path $filepath 
$csv = import-csv -path $filepath 
$csvname = $csv.firstname
$firstname = $Globalfirstname
$lastname = $Globallastname

if ($testpath -eq "True"){
write-host "Database File Exists" -ForegroundColor Yellow
}else{
write-host "Warning! File '$filepath' does not exist. `n Check your path and try again" -ForegroundColor Yellow -BackgroundColor Black
pause
exit
}

#Display a message "Editing client _______  _________ information" (name from option 2)
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-host "     Editing client $firstname $lastname information  "    #need option 2 global variables 
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White

#Use the [array]::IndexOf(ArrayName, StringToLookFor) static method to find the client's index position in the array
$index = [array]::IndexOf($csvname, $firstname)
#write-host $index

#Provide user input to amend client properties at the appropriate index position
#[Parameter(Mandatory=$true)][string]
$fname = Read-Host ("Enter first name ")
$lname = Read-Host ("Enter last name  ")
$Business = Read-Host ("Enter business type ") 
$Telephone = Read-Host ("Enter telephone number ")
$Email = Read-Host("Enter email address ")
#lea silva retailer 799-848-1304 chunzi@comcast.net

#flag for matching the index and the name
if ($firstname -match $csvname[$index]){
        $match = $true
        $csv[$index].firstname = $fname
        $csv[$index].lastname = $lname
        $csv[$index].business = $Business
        $csv[$index].telephone = $Telephone
        $csv[$index].email = $Email
}else{
    $match=$false
}

#Save the file with amended properties to the save directory but with a different name.
#>Remove the old database file
#>Rename the new file with the old name clientinfo.csv.
$csv | export-csv -Path $filepath -NoTypeInformation

#Display a message "Client information edited"
if ($match -eq $true){
write-host ("Client information edited") -ForegroundColor DarkGreen -BackgroundColor White
}else{
exit
}