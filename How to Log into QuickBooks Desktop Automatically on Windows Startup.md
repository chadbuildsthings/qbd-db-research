How to Log into QuickBooks Desktop Automatically on Windows Startup
===================================================================

# Prerequisites

1. Quickbooks Enterprise installed on Windows Server 2022  
2. AutoHotkey v2 installed  
3. Configured Windows to Automatically log in to a user account with adequate permissions on startup

# Disable QuickBooks Helper Programs on Startup

1. We do this to prevent the helper programs from starting up which can cause problems auto logging in if there’s an error. Note: the author doesn’t use Intuit Data Protect and takes software updates manually, so has no problem disabling these as potential crashes might interfere with automatic login.   
2. Win+i to open Settings App  
3. Search for and enter Startup Apps  
4. Turn off the following:  
   1. Intuit Data Protect  
   2. Program (Pretty sure this is the update program)  
   3. Quickbooks  
   4. Quickbooks Web Connector (we will schedule this to be turned on another way)

# Setting up the AutoHotkey Scripts Folder and Script

Create the directory structure C:\\AutoHotkey\\Scripts and copy the file qbstartup.ahk inside this directory. Then edit the qbstartup.ahk to change the following environment variables to match that of your Quickbooks Desktop installation

## Path to your QuickBooks executable

qbwPath := "C:\\Program Files\\Intuit\\QuickBooks Enterprise Solutions 24.0\\QBW.exe"

## Path to your QuickBooks Web Connector Executable

qbwcPath := "C:\\Program Files (x86)\\Common Files\\Intuit\\QuickBooks\\QBWebConnector\\QBWebConnector.exe"

## Path to your QuickBooks Company File

companyFilePath := "C:\\Users\\Public\\Documents\\Intuit\\QuickBooks\\Company Files\\enter-company-filename-here.qbw"

## QuickBooks Administator Username

username := "enter-admin-username-here"

## Quickbooks Administrator Password

password := "enter-admin-password-here"

# Create a Task in Task Scheduler

1. Win+R \> taskschd.msc \> OK  
2. Create Task  
3. General Tab  
   1. Name: qbstartup.ahk  
   2. Run with highest privileges  
      1. Note: this prevents UAC dialog on bootup  
4. Triggers Tab  
   1. Click New…  
      1. Begin the task: At Startup  
      2. Enabled: check  
      3. Click OK  
5. Actions Tab  
   1. Click New…  
      1. Action: Start a Program  
      2. Program/script  
         1. Click Browse…  
         2. Select your AutoHotkey Executable  
            1. e.g. C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe  
            2. Click Open  
      3. Add arguments (optional): Add the path of your qbstartup.ahk script here in double quotes  
         1. e.g. “C:\\AutoHotkey\\Scripts\\qbstartup.ahk”  
      4. Click OK  
6. Settings Tab  
   1. Uncheck Allow task to be run on demand  
   2. Check If the task fails, restart every 1 minute  
   3. Attempt to restart up to 3 times  
   4. If the running task does not end when requested, force it to stop  
   5. If the task is already running, then the following rule applies: Do not start a new instance  
   6. Click OK

