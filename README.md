# Mission

The mission of this project is to provide a repository of research, guides, and tools for:

1. Creating fast, stable remote ODBC connections to Quickbooks Desktop instances for running read-only SQL queries regardless of whether or not the local user is logged into QuickBooks Desktop locally  
2. Understanding the structure of the internal SQL Anywhere Database used by Quickbooks Desktop for writing read-only SQL queries

# Sample Use Cases

1. Reporting on multi-location inventory data is possible with Quickbooks Desktop for Enterprise  
2. Running queries that can join tables from other databases present in the same Microsoft SQL Server instance  
3. Reports run in a fraction of the time when using this method as compared to using API access

# Prerequisites

1. Quickbooks Desktop (versions with ODBC access)  
2. Microsoft SQL Server Standard or Enterprise (versions with support for Linked Servers)
3. Microsoft SQL Server Management Studio
4. Auto Hotkey v2
