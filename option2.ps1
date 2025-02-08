<#option2
A basic database task is to test if a client's name is in the database  or not.  
If the name is found save the first and last names to out of scope Script variables so that the name can be used by menu options 3 and 4. 
If the name is not found, the user will select option 5 and add the user to the database.
#>

#>Test if the path to the database file exists and if not exit with a message
$filepath = ".\clientinfo.csv"
$testpath = Test-Path $filepath 
$csv = import-csv -path $filepath 
$csvname = $csv.firstname

if ($testpath -eq "True"){
write-host "Database File Exists" -ForegroundColor Yellow
}else{
write-host "Warning! File '$filepath' does not exist. `n Check your path and try again" -ForegroundColor Yellow -BackgroundColor Black
pause
exit
}
#>Accept user input as "Enter client name [Jane Doe]?" (both first and last names) #>Split the input into first and last names and save as script scope variables

$Global:Globalfirstname, $Global:Globallastname = (Read-Host "Enter client name [Jane Doe]? ") -split " "

#>Display a message if the client name is in the database or not
for ($i = 0; $i -lt $csvname.count; $i++) { 
    if ($Global:Globalfirstname -eq $csvname[$i]) {
        $matcher = $true
        break #exit loop when match is found*
    } else {
        $matcher = $false
    }
}


if ($matcher -eq $true){
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-Host ("                         Client is in Database file                         ")
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
pause #dont know if this Pause is in the menu or in my function... For it to continue to the menu again after entering "enter" 
}else {
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
write-host ("                               CLIENT NOT FOUND                     ") -ForegroundColor Red -BackgroundColor Black
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
pause
}

$matcher = $null 