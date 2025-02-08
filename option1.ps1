<#
A problem of CSV files is the possibility of duplicates. A duplicate last name is allowed. 
A duplicate first name is allowed, but a duplicate last and first name is not allowed. 
This is a problem when you have multiple user input. 
Therefore, your function must remove duplicates with the same first and last names.
#>


#Test if the path to the database file exists and if not exit with a message
$filepath = ".\clientinfo.csv"
$testpath = Test-Path $filepath 

if ($testpath -eq "True"){
write-host "Database File Exists `n" -ForegroundColor Yellow
}else{
write-host "Warning! File '$filepath' does not exist. `n Check your path and try again" -ForegroundColor Yellow -BackgroundColor Black
pause
exit
}

#Test to see if duplicate first and last names exist in the database
#Count and display now many duplicates exist
$csvimport = Import-Csv -Path $filepath #-Header $firstheader, $secondheader 
$check = 0
$fcontainer = @()
$lcontainer = @()

[System.Collections.ArrayList]$firstname = @($csvimport.Firstname) 
[System.Collections.ArrayList]$lastname = @($csvimport.Lastname) 

for ($i = 0; $i -le $firstname.count; $i++){
    for ($j = $i+1; $j -le $firstname.count; $j++){
        if($firstname[$i] -eq $firstname[$j] -and $lastname[$i] -eq $lastname[$j]) {
        $check++
        $fcontainer += $firstname[$i] #contain the names of the duplicates to remove
        $lcontainer += $lastname[$i]
        }
    }
}

if ($check -gt 0){
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-Host ("            There are $check Duplicates Found!                    ") -foregroundcolor Red -BackgroundColor black #count and display 
Write-Host ("==========================================")  -ForegroundColor Green -BackgroundColor White
write-host ("`n")
write-host ("Remove Duplicates? Please CTRL+C to exit or ") 
pause 
}else{
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-Host ("            There are $check Duplicates Found!                    ") -foregroundcolor Red -BackgroundColor black #count and display 
Write-Host ("==========================================")  -ForegroundColor Green -BackgroundColor White
exit
}

#Give the user the option to exit the program or continue to remove duplicates
for ($i = 0; $i -le $firstname.count; $i++){
    for ($j = $i+1; $j -le $firstname.count; $j++){
        if($firstname[$i] -eq $firstname[$j] -and $lastname[$i] -eq $lastname[$j]) {
           $firstname.Remove($fcontainer[$i]) #remove those names from ArrayList using the containers 
           $lastname.Remove($lcontainer[$i])
        }
    }
}


#Save the file with duplicates removed to the save directory but with a different name. #Remove the old database file #Rename the new file with the old name clientinfo.csv. 
#Display a message "Removed Duplicates" (note if the duplicate count is 0, then this message should not appear).
#if option 3 then do this and display message
$csvimportnew = import-csv $filepath |sort firstname,lastname,business,telephone,email -unique 
$csvimportnew | export-csv -path $filepath -NoTypeInformation

if ($check -ge 0){ 
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
Write-Host ("                     Removed Duplicates                             ")-ForegroundColor Yellow -BackgroundColor Black
Write-Host ("==========================================") -ForegroundColor Green -BackgroundColor White
}







