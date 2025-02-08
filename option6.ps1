<#option 6 
A unique feature of PowerShell is the ability to create an interactive GUI window of the database so the
user and select the criteria on which to sort the information, for example selecting all contractors to
send a special product flyer by email.
#>

#Test if the path to the database file exists and if not exit with a message
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

#Import the database file and send all properties to an interactive GUI window
#Allow user selection to be piped to Out-File to create a Client Report with today's date in the title
$Date = Get-Date

$csv | Out-GridView -Title "$Date Client Info" -passthru | Out-File -FilePath ".\ $(get-date -f yyyy-MM-dd) clientInfo.txt"



