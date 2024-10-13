How to Connect to Quickbooks Desktop with ODBC using Microsoft SQL Server
=========================================================================

# Prerequisites

1. Quickbooks Enterprise installed (I'm using 2024\)  
2. SQL Server Standard or higher installed (I'm using 2019 Standard)  
3. SQL Server Management Studio installed (I'm using version 20\)  
4. A user created to log in with

# Creating a Connection String

To set up a Linked Server that is connected to Quickbooks, we have to use a Provider String that is 32 characters or less. 

1. The provider string has 2 components, each of which count towards this 32 character limit  
   1. FILEDSN=  
   2. The path to the connection file located in your quickbooks directory  
2. Therefore we only have 24 characters to use for our file path.  
3. There are also some caveats  
   1. Any \\ character must be replaced with the characters \\\\  
   2. If you have any spaces in your path, you must enclose the entire path with double quotes, which also count towards the limit  
   3. You cannot use a UNC path (Note: A mapped drive might work, but I haven’t tested this)  
4. There are a few things that can be done to get this file dsn path character count down  
   1. Make sure your server name is as short as possible (e.g. QBE)  
   2. Create an NTFS junction in C:\\ (e.g. C:\\QB) to point to C:\\Users\\Public\\Intuit\\Quickbooks\\Company files  
      1. From cmd or powershell, issue this example command:  
         ```mklink /J C:\\QB C:\\Users\\Public\\Intuit\\Quickbooks\\Company files``` 
   3. Rename your company data file to be a single letter with .qbw extension. To do this, follow these steps.  
      1. Log everyone out of Quickbooks  
      2. Close Quickbooks  
      3. Go to your company data directory in File Explorer (e.g. C:\\Users\\Public\\Intuit\\Quickbooks\\Company files or C:\\QB)  
      4. Make sure you can see file extensions in File Explorer  
         1. Click View tab  
         2. Make sure File Name extensions is checked  
      5. Find your company data file. It will have a .qbw extension  
      6. Right click on it and click Rename  
      7. Make it a single letter and .qbw (e.g. s.qbw)  
      8. Double click it to open Quickbooks  
      9. Verify in file explorer that there now exists a file named the same way as your new company data file, but with a .dsn extension (e.g. s.qbw.DSN)  
      10. Make sure to go to all computers (workstations and remote desktop session hosts) that access this company file and reopen it. This will ensure the next time a user logs in, they can access your company’s data file without having to browse for it.  
      11. Now we should be able to have a provider string 32 characters or less (e.g. FILEDSN=C:\\QB\\s.qbw.DSN is only 23 characters)

# Creating an ODBC User

1. Log in to Quickbooks using the admin account  
2. Go to Reports \> Custom Reports \> ODBC  
3. Click “Manage ODBC Users”  
4. Click New…  
   1. Give an ODBC User Name  
   2. Create a password. (Note I had issues using symbols)  
   3. Confirm password  
   4. Click QBReportAdminGroup  
   5. Click Add \>\>  
   6. Click OK

# Create a Linked Server

5. Open SQL Server Management Studio  
6. In the Object Explorer, expand your SQL Server Instance  
7. Expand Server Objects  
8. Right Click Linked Servers  
9. Click “New Linked Server”  
10. In the General page  
    1. Give it a Linked Server name (e.g. QB\_LINK)  
    2. Tick “Other data Source”  
    3. Use provider string generated from the first section (e.g. FILEDSN=C:\\QB\\s.qbw.dsn)  
11. In the Security page  
    1. Tick “Be made using this security context:”  
       1. Remote login: enter ODBC User Name from Quickbooks  
       2. With password: enter ODBC Password from Quickbooks  
12. Click OK. There shouldn’t be any errors.  
13. Verify that it worked  
    1. Assuming you named your linked server QB\_Link  
    2. Click New Query  
    3. Enter the following:  
       1. SELECT \* FROM OPENQUERY(\[QB\_LINK\], ‘SELECT DB\_NAME() AS CurrentDatabase’);  
       2. Click Execute  
       3. A result should appear with column header “Current Database” and row 1 value being a long string of numbers and letters ranging from a through f  
       4. If you get a result like this, it worked.
