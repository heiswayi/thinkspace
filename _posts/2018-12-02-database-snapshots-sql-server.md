---
layout: post
title: How To Simplify Database Snapshots Creation in SQL Server
description: How To Simplify Database Snapshots Creation in SQL Server
comments: false
keywords: SQL Server Database Snapshots
published: true
---

**Database Snapshots** is a powerful feature that can be used for quick reverts of the database to the state as it was in when a given database snapshot was created, but also for reporting on data and schema comparison between a source database and a snapshot.

This feature was shipped in SQL Server 2005 however used to be available only in Enterprise edition. In release SQL Server 2016 SP1 Microsoft made a generous step and unlocked plenty of such enterprise grade features. Since that database snapshots become ready to use in all editions, including Express.  

#### Warning:

> Database snapshots are dependent on the source database. Therefore, using database snapshots for reverting a database is not a substitute as your primary **backup and restore strategy**. Performing all your scheduled backups remains essential.

This feature has a clear syntax, however, SSMS has no wizard or GUI and generation of multiple snapshots require some tedious work:

```sql
CREATE DATABASE [AdventureWorks2016_snapshot] 
ON (NAME = [AdventureWorks2016_Data], FILENAME ='H:\SQL_Data\Data\AdventureWorks2016_Data.mdf.snapshot')
AS SNAPSHOT OF [AdventureWorks2016];
```



Because of lack of UI stored procedure `[dbo].[uspCreateSnapshot]` was created. 

This procedure procedure has following parameters:

| Parameter               | Type    | Default Value | Description      |
| ----------------------- |:--------| -------------:| ---------------- |
| @SourceDBSearchPattern  | sysname | 'all'         | Determines a list of databases to process, it uses LIKE pattern seach. When value set to All then all user databases selected                 | 
| @SnashotSuffix          | sysname | 'snapshot'    | Snapshot name suffix, the full snapshot name will have a value: databasename_suffixname                 |
| @DropIfExists           | bit     | 0             | Remove old snapshot on the same source database if  snapshot name is also the same                 |
| @Debug                  | bit     | 0             |  Prints output as SQL Script, but does not execute it                |

## Installation

The source code can be retrieved from the github repository [github/avolok/scripts](https://github.com/avolok/scripts/tree/master/DBA) or by direct download: [[dbo].[uspCreateSnapshot]](https://raw.githubusercontent.com/avolok/scripts/master/DBA/uspCreateSnapshot.sql)



## Examples

### A.	Creating a snapshot on a single database

This example creates a snapshot on a single database using default values. Snapshot name is: *AdventureWorks2016_snapshot*. 

    exec [dbo].[uspCreateSnapshot] 'AdventureWorks2016'

If snapshot with such name already exists the procedure will results to a message:

```sql
-- Processing database: [AdventureWorks2016]
-- Snapshot [AdventureWorks2016_Snapshot] already created on database [AdventureWorks2016], nothing more to do
```


### B.	Creating snapshots on multiple databases that selected by a search pattern 
This example also doing something

```sql
EXEC [dbo].[uspCreateSnapshot] @SourceDBSearchPattern = 'DBName0%', 
                               @SnashotSuffix = 'ss'                
```

### C.	Creating snapshot by dropping existing one
This example also doing something

```sql
EXEC [dbo].[uspCreateSnapshot] @SourceDBSearchPattern = 'DBName0%',           
                               @DropIfExists = 1                    
```

### D.	Generating T-SQL for snapshot creation
This example also doing something

```sql
EXEC [dbo].[uspCreateSnapshot] @SourceDBSearchPattern = 'AdventureWorks2016',
                               @Debug = 1                                
```

The output:

```sql
-- Processing database: [AdventureWorks2016]

-- Executing SQL:
CREATE DATABASE [AdventureWorks2016_Snapshot] ON 
(NAME = [AdventureWorks2016_Data], FILENAME ='H:\SQL_Data\Data\AdventureWorks2016_Data.mdf.Snapshot')
AS SNAPSHOT OF [AdventureWorks2016];	
```


