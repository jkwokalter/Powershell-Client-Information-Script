<#option4
As well as editing client information, databases have to be updated by removing client names. 
Customers die, or move out of your service area, or are influenced by family members not to buy from you. 
For these reasons, databases must be updated daily to remove names who will no longer be clients.
#>

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

#Display a message "Removing client ___________ _______________ information" (name from option 2)
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-host "     Removing client $firstname $lastname information  "    #need option 2 global variables 
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White

#Use the [array]::IndexOf(ArrayName, StringToLookFor) static method to find the client's index position in the array
$index = [array]::IndexOf($csvname, $firstname)
#write-host $index

#Remove that position from the array and save array variable with a new name

$value1 = $csvname[$index]

$test = import-csv -path $filepath | where {$_.firstname -ne $firstname}
$testname = $test.firstname

$value2 = $testname[$index]

if ($value1 -ne $value2) 
{
    $match -eq $true
}
else
{
    $match -eq $false
}

#Save the file with amended properties to the save directory but with a different name.
#>Remove the old database file
#>Rename the new file with the old name clientinfo.csv.
$test | export-csv -Path $filepath -NoTypeInformation


#Display a message "Client information removed"
if ($match -eq $true){
write-host ("Client information removed") -ForegroundColor DarkGreen -BackgroundColor White
}else{
exit
}

