; ------------------------------------------------------------
; qbstartup.ahk
; repo: https://github.com/chadbuildsthings/qbd-db-research/
; 2024-10-13
; Script to automate QuickBooks Enterprise startup and login
;-------------------------------------------------------------

;-------------------------------------------------------------
; Environment Variables
; Fill in the following variables for your environment
;-------------------------------------------------------------

; Path to your QuickBooks executable
qbwPath := "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 24.0\QBW.exe"

; Path to your QuickBooks Web Connector Executable
qbwcPath := "C:\Program Files (x86)\Common Files\Intuit\QuickBooks\QBWebConnector\QBWebConnector.exe"

; Path to your QuickBooks Company File
companyFilePath := "C:\Users\Public\Documents\Intuit\QuickBooks\Company Files\enter-company-filename.qbw"

; QuickBooks Administator Username
username := "enter-admin-username-here"

; Quickbooks Administrator Password
password := "enter-admin-password-here"

;------------------------------------------------------------
; The Procedure
;------------------------------------------------------------

; Open the company file in quickbooks to get straight to a login screen
;  Note: this only works if no other instance of qbw.exe is running (like at boot)
Run(Format('"{1}" "{2}"', qbwPath, companyFilePath))

; Wait for QuickBooks to load
WinWait("ahk_exe QBW.EXE")

; Activate once it's loaded
WinActivate("ahk_exe QBW.EXE")

; Wait for login window to appear
; Note: this will not appear if there’s another instance
;  of qbw.exe running. Check task manager.
WinWait("QuickBooks Desktop Login")

; Activate login window
WinActivate("QuickBooks Desktop Login")

; Move mouse to username field and click
MouseMove(250, 130)
Click

; Quickbooks automatically sends the cursor back down
;  to the password field.
;  Shift+Tab to go back to the username field
;  Type the username
;  Tab to password field
;  Type password
;  Press enter to log in
Send("+{Tab}" username "{Tab}" password "{Tab}{Enter}")

; Wait 5 seconds and start the Quickbooks Web Connector
; Note: Make sure to disable this at startup. If for some
;  reason it fails, it's error message can block automatic
;  login to Quickbooks
Sleep(5000)
Run('"' qbwcPath '" -keephidden')
