---
layout: post
title: How To Simplify Database Snapshots Creation in SQL Server
description: Ideas for a new blog post
comments: true
keywords: SQL Server Database Snapshots
published: true
---

**SQL Server Database Snapshots** is a useful feature that can be used for quick reverts of the database to the state it was in when a given database snapshot was created to the state at, but also for reporting on data and schema comparison between a source database and a snapshot.

Database snapshots are available since SQL Server 2005 however only in Enterprise edition. Since release of SQL Server 2016 SP1 Microsoft made a generous step and unlocked plenty of such enterprise grade features. Since that database snapshots become ready to use in all editions, including Express. 
Warning

> Database snapshots are dependent on the source database. Therefore, using database snapshots for reverting a database is not a substitute for your backup and restore strategy. Performing all your scheduled backups remains essential. If you must restore the source database to the point in time at which you created a database snapshot, implement a backup policy that enables you to do that.

This feature has a clear syntax:

```sql
CREATE DATABASE [AdventureWorks2016_snapshot] 
ON (NAME = [AdventureWorks2016_Data], FILENAME ='H:\SQL_Data\Data\AdventureWorks2016_Data.mdf.snapshot')
AS SNAPSHOT OF [AdventureWorks2016];
```

However, SSMS has no wizard or GUI and generation of multiple snapshots require some tedious work.

Because of this `[dbo].[uspCreateSnapshot]` has been created. 

Stored procedure has following parameters:

| Parameter               | Type    | Default Value | Description      |
| ----------------------- |:--------| -------------:| ---------------- |
| @SourceDBSearchPattern  | sysname | 'all'         | Determines a list of databases to process, it uses LIKE pattern seach. When value set to All then all user databases selected                 | 
| @SnashotSuffix          | sysname | 'snapshot'    | Snapshot name suffix, the full snapshot name will have a value: databasename_suffixname                 |
| @DropIfExists           | bit     | 1             | Remove old snapshot on the same source database if  snapshot name is also the same                 |
| @Debug                  | bit     | 1             |  Prints output as SQL Script, but does not execute it                |




## Examples

### A.	First example

This example do something

`<Code>`

### B.	Second example
This example also doing something

`<Code>`

The source code can be retrieved from github.
