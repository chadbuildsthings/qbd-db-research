# Mission

The mission of this project is to provide a repository of research, guides, and tools for:

1. Creating fast and stable ODBC connections to Quickbooks Desktop instances for running read-only SQL queries regardless of whether or not the local user is logged into QuickBooks Desktop locally  
2. Understanding the structure of the internal SQL Anywhere Database used by Quickbooks Desktop for writing read-only SQL queries

# Sample Use Cases

* Reporting on multi-location inventory data is possible with Quickbooks Desktop for Enterprise
* Running queries that can join tables from other databases present in the same Microsoft SQL Server instance
* Reports run in a fraction of the time when using this method as compared to using API access

# Prerequisites

* Quickbooks Desktop (versions with ODBC access)
* Microsoft SQL Server Standard or Enterprise (versions with support for Linked Servers)
* Microsoft SQL Server Management Studio
* Auto Hotkey v2

# Documentation

Check out and help contribute to our research in our [Wiki](https://github.com/chadbuildsthings/qbd-db-research/wiki)
