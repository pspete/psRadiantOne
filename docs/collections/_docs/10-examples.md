---
title: "Examples"
permalink: /docs/examples/
excerpt: "Common tasks with psRadiantOne"
---

## Working With The Namespace

```powershell
# List the naming contexts, following the API's pagination to the end
PS C:\> Get-R1NamingContext

# Browse the directory
PS C:\> Get-R1DirectoryEntry -dn 'o=vds'

# Search it - supply a filter and a scope, and every page is followed
PS C:\> Get-R1DirectoryEntry -dn 'o=vds' -filter '(objectClass=inetOrgPerson)' -scope SUB
```

## Directory Entries

```powershell
# Create an entry. The dn is the dn of the new entry, not of its parent
PS C:\> New-R1DirectoryEntry -dn 'uid=jbloggs,ou=people,o=companydirectory' -attributes @(
    @{ name = 'objectClass'; values = @('top', 'person', 'organizationalperson', 'inetorgperson') }
    @{ name = 'uid'; values = @('jbloggs') }
    @{ name = 'cn'; values = @('Joe Bloggs') }
    @{ name = 'sn'; values = @('Bloggs') }
)

# Modify it. REPLACE overwrites, ADD appends to the values already there, and DELETE with no
# values removes the attribute
PS C:\> Set-R1DirectoryEntry -dn 'uid=jbloggs,ou=people,o=companydirectory' -modifications @(
    @{ modifyType = 'REPLACE'; attributes = @(@{ name = 'l'; values = @('Chester') }) }
    @{ modifyType = 'ADD'; attributes = @(@{ name = 'mobile'; values = @('+44 7700 900000') }) }
    @{ modifyType = 'DELETE'; attributes = @(@{ name = 'employeeType'; values = @() }) }
)

# Set a password, and check it. Every password parameter in the module is a securestring
PS C:\> $Password = Read-Host -Prompt 'Password' -AsSecureString
PS C:\> Reset-R1DirectoryEntryPassword -dn 'uid=jbloggs,ou=people,o=companydirectory' -password $Password
PS C:\> Test-R1DirectoryAuthentication -dn 'uid=jbloggs,ou=people,o=companydirectory' -password $Password

# Group membership. The member list is replaced, not added to, and the server does not check that
# a member entry exists
PS C:\> Get-R1DirectoryEntryMember -dn 'cn=admins,ou=groups,o=companydirectory'
PS C:\> Set-R1DirectoryEntryMember -dn 'cn=admins,ou=groups,o=companydirectory' -members @(
    'uid=jbloggs,ou=people,o=companydirectory'
)

# Rename, move, and remove. An entry with children needs -deleteSubNodes
PS C:\> Rename-R1DirectoryEntry -dn 'uid=jbloggs,ou=people,o=companydirectory' -newRdn 'uid=joe.bloggs'
PS C:\> Move-R1DirectoryEntry -dn 'uid=joe.bloggs,ou=people,o=companydirectory' -newParentDn 'ou=leavers,o=companydirectory'
PS C:\> Remove-R1DirectoryEntry -dn 'uid=joe.bloggs,ou=leavers,o=companydirectory'
```

## Import & Export

```powershell
# Export a subtree to a file on the server, then download one
PS C:\> Export-R1DirectoryLdif -sourceDn 'ou=people,o=companydirectory' -scope SUB -fileName 'people.ldif'
PS C:\> Get-R1DirectoryLdifFile
PS C:\> Save-R1DirectoryLdif -sourceDn 'ou=people,o=companydirectory' -scope SUB -fileName 'people.ldif' -Path 'C:\Exports'

# Import runs as a task, which is returned
PS C:\> $Task = Import-R1DirectoryLdif -filename 'people.ldif'
PS C:\> Get-R1Task -id $Task.id
PS C:\> Get-R1TaskLog -id $Task.id
```

The export is written by the server in its own time, so the file does not appear in `Get-R1DirectoryLdifFile` the instant the command returns.

## Data Sources & Schemas

```powershell
# List the data sources, or retrieve one by name
PS C:\> Get-R1DataSource
PS C:\> Get-R1DataSource -name 'corporate-ldap'

# Inspect what a data source exposes
PS C:\> Get-R1DataSourceObject -name 'corporate-ldap'

# Look inside an LDAP data source without creating a schema for it first
PS C:\> Get-R1LdapDataPreview -dataSourceName 'corporate-ldap' -baseDn 'o=companydirectory'

# Search across data sources and the objects they hold. Both filters are a case-insensitive
# contains match, not a wildcard, and at least one of them is required
PS C:\> Search-R1DataSource -dataSourceFilter 'ldap'
PS C:\> Search-R1DataSource -objectFilter 'person'

# List the schemas, then the tables and fields of one
PS C:\> Get-R1Schema
PS C:\> Get-R1SchemaTable -schemaName 'employees'
PS C:\> Get-R1SchemaTableField -schemaName 'employees' -tableName 'person'
```

A data source is contacted when a schema is created against it, so it has to be reachable - an unreachable host is refused rather than stored.

## Users & Roles

```powershell
# Every page of users is followed
PS C:\> Get-R1FIDUser
PS C:\> Get-R1FIDUser -username 'some.user'

PS C:\> Get-R1FIDRole

# Create a control panel user, then assign roles. The role list is the complete set - a role left
# out is taken away
PS C:\> New-R1FIDUser -username 'some.user' -password $Password -active $true -email 'some.user@somedomain.com'
PS C:\> Set-R1FIDUserRole -username 'some.user' -roles @('Operator')
```

A user's password is never returned by a read; it comes back null.

## Access Tokens

Long-lived tokens for calls made outside an interactive session:

```powershell
# The create returns the token string itself, and is the only time it can be read - a later read
# returns the token's properties with an empty value. It is kept out of the session object too, so
# it won't turn up in (Get-R1Session).LastCommandResults
PS C:\> $Token = New-R1AccessToken -name 'reporting' -apiType REST -expiresOn (Get-Date).AddDays(30)

PS C:\> Get-R1AccessToken
PS C:\> Remove-R1AccessToken -name 'reporting'
```

## Access Control

```powershell
# With no -baseDn this returns the acis held at the root, not every aci on the deployment. An aci
# added at an entry is listed only when that entry's dn is passed
PS C:\> Get-R1Aci
PS C:\> Get-R1Aci -baseDn 'ou=people,o=companydirectory'

# Build one from individual permissions - the server assembles the aci string. A dn given to
# -applyUserDns is prefixed with ldap:/// by the server, so pass the dn on its own
PS C:\> New-R1Aci -baseDn 'ou=people,o=companydirectory' -name 'self-read' -permsType ALLOW -selectedOperations @('READ', 'SEARCH') -applyUserDns @('uid=jbloggs,ou=people,o=companydirectory')

# Parse an aci string and see how the server reads it
PS C:\> Test-R1Aci -aciString '(targetattr = "*")(version 3.0;acl "self-read";allow (read,search) userdn = "ldap:///self";)'
```

## Tasks

```powershell
PS C:\> Get-R1TaskScheduler
PS C:\> Get-R1Task
PS C:\> Get-R1Task -id $Id

# Start and stop a task by id
PS C:\> Start-R1Task -id $Id
PS C:\> Stop-R1Task -id $Id

# A task log can run to tens of thousands of lines; -numberOfLines tails it instead of downloading
# the whole thing
PS C:\> Get-R1TaskLog -id $Id -numberOfLines 50
```
