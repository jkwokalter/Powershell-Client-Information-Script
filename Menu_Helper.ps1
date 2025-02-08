#set the strict mode to latest version
 Set-StrictMode -Version Latest

 #dot source the menu file to be loaded to the current scope
 . .\Assignment_Menu.ps1
 . .\option2.ps1

 Do {

#clears the screen 
Clear-Host
#displays the menu with the correct colours
Write-Host "$menu" -ForegroundColor White -BackgroundColor Green

#waits for user input
$selection = Read-Host "Enter a selection [1-7]"
Write-Output "`n`n"

#Creates options
Switch ($selection){

    '1'{& ".\option1.ps1";pause;break}
    '2'{& ".\option2.ps1";pause;break}
    '3'{& ".\option3.ps1";pause;break}
    '4'{& ".\option4.ps1";pause;break}
    '5'{& ".\option5.ps1";pause;break}
    '6'{& ".\option6.ps1";pause;break}
    '7'{;exit;break}
    Default{"Invalid Input";pause;break}

    }

}until ($selection -eq  '7')