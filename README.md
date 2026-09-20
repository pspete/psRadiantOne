![Logo][Logo]

[Logo]: /docs/media/images/psRadiantOne.png

# psRadiantOne

psRadiantOne is a PowerShell module that wraps the REST API of the [Radiant Logic RadiantOne][vendor] platform, giving you commands for authentication and administration - the global namespace, the directory schema and browser, data sources and schemas, security settings, tasks, configuration promotion and the file manager - all from within PowerShell.

The module covers the RadiantOne v8.x API as published in the vendor's OpenAPI definition, and targets both self-hosted deployments and SaaS tenants.

[vendor]: https://www.radiantlogic.com/

- **Prior to a Version 1.0.0 release**:
  - Expect changes, although we will do our best to keep these to a minimum
  - Issues / PRs are encouraged & appreciated
  - Most commands have now been exercised against a live deployment, but around 1 in 9 still rest on the published API definition alone - see [Help Us Test](#help-us-test) below, your feedback genuinely shapes what ships next.
  - Real-world usage is still expected to shape further changes to command names, parameters/parameter names, and how commands are grouped - some may split into companion commands, others may combine. These patterns only emerge once commands are actually used, so don't consider anything final yet.

| Main Branch              | Latest Build             | CodeFactor                 | Coverage                     | PowerShell Gallery        | License                      |
| ------------------------ | ------------------------ | -------------------------- | ---------------------------- | ------------------------- | ---------------------------- |
| [![appveyor][]][av-site] | [![tests][]][tests-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![psgallery][]][ps-site] | [![license][]][license-link] |

[appveyor]: https://ci.appveyor.com/api/projects/status/github/pspete/psRadiantOne?branch=main&svg=true
[av-site]: https://ci.appveyor.com/project/pspete/psRadiantOne/branch/main
[psgallery]: https://img.shields.io/powershellgallery/v/psRadiantOne.svg
[ps-site]: https://www.powershellgallery.com/packages/psRadiantOne
[tests]: https://img.shields.io/appveyor/tests/pspete/psRadiantOne.svg
[tests-site]: https://ci.appveyor.com/project/pspete/psRadiantOne
[downloads]: https://img.shields.io/powershellgallery/dt/psRadiantOne.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/psRadiantOne
[codefactor]: https://www.codefactor.io/repository/github/pspete/psradiantone/badge?s=1093220a061c51b1db44a6f3d7fa8b9fb23d4a6f
[codecov]: https://codecov.io/gh/pspete/psRadiantOne/branch/main/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/psRadiantOne
[license]: https://img.shields.io/github/license/pspete/psRadiantOne.svg
[license-link]: https://github.com/pspete/psRadiantOne/blob/main/LICENSE.md

---

## Use Cases

### Authenticate

Every command in the module works against a session established by `Connect-R1Session`:

```powershell
PS C:\> $Credential = Get-Credential
PS C:\> Connect-R1Session -BaseURI 'https://sometenant.example.radiantlogic.io/api' -Credential $Credential
```

`-BaseURI` takes the **API endpoint** address, not the Control Panel UI address. On a cloud tenant this is the Control Panel address with `/api` appended; both are listed in the EOC Application Endpoints panel. On a self-hosted deployment it looks like `https://radiantone.lab.local:7070/api`.

### Session Data

`Get-R1Session` returns a copy of the module scope session:

```powershell
PS C:\> Get-R1Session

BaseURI         : https://sometenant.example.radiantlogic.io/api
User            : some.user@somedomain.com
Organization    : sometenant
Version         : 8.5.3
StartTime       : 13/09/2026 22:58:13
ElapsedTime     : 00:25:30
TokenExpiry     : 13/09/2026 23:58:13
LastCommandTime : 13/09/2026 23:23:07
```

The token, the WebSession carrying it, the result of the last command and the last error are on the object but are not printed, so the session can be shown and pasted without exposing the token. Ask for them by name:

```powershell
# The privileges the token grants are worth checking when a command fails with an authorization error
PS C:\> (Get-R1Session).Privileges

# Everything the session holds
PS C:\> Get-R1Session | Select-Object -Property *
```

The WebSession carries the token, so it can be handed to `Invoke-WebRequest` for a call the module has no command for:

```powershell
PS C:\> $Session = Get-R1Session
PS C:\> Invoke-WebRequest -Uri "$($Session.BaseURI)/some-service/some_endpoint" -WebSession $Session.WebSession
```

The object is a copy: changing it does not alter the session other commands use.

`Update-R1AuthToken` renews the token, and `Disconnect-R1Session` revokes it and clears the session.

### Working With The Namespace

```powershell
# List the naming contexts, following the API's pagination to the end
PS C:\> Get-R1NamingContext

# Browse the directory
PS C:\> Get-R1DirectoryEntry -dn 'o=vds'

# Search it - supply a filter and a scope, and every page is followed
PS C:\> Get-R1DirectoryEntry -dn 'o=vds' -filter '(objectClass=inetOrgPerson)' -scope SUB
```

### Directory Entries

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

### Import & Export

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

### Data Sources & Schemas

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

### Users & Roles

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

### Access Tokens

Long-lived tokens for calls made outside an interactive session:

```powershell
# The create returns the token string itself, and is the only time it can be read - a later read
# returns the token's properties with an empty value. It is kept out of the session object too, so
# it won't turn up in (Get-R1Session).LastCommandResults
PS C:\> $Token = New-R1AccessToken -name 'reporting' -apiType REST -expiresOn (Get-Date).AddDays(30)

PS C:\> Get-R1AccessToken
PS C:\> Remove-R1AccessToken -name 'reporting'
```

### Access Control

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

### Tasks

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

## Things Worth Knowing

- **Updates read before they write.** Every `Set-*` command issuing a `PUT` retrieves the resource first and sends it back with the supplied values applied over it, so a property you don't specify keeps its current value.
- **Some commands replace a whole collection.** `Set-R1FIDUserRole`, `Set-R1DirectoryEntryMember`, `Set-R1LdapClientAccessMapping` and `Set-R1CustomLimit` take the complete collection, so anything omitted is removed. Their help says so.
- **Paged results are followed to the end.** A command which reads a collection returns all of it; there is no page parameter to advance by hand.
- **Secrets are secure strings.** Every password, secret and key parameter takes a `[securestring]`, and the request body carrying one is built as a byte array so it can't be captured by PowerShell's parameter binding or module logging.
- **A clean return is not always proof.** Several endpoints answer `200` to a request that did nothing, or answer with an empty result whether or not the thing addressed exists. Where that is known, the command's `NOTES` says so - read it back to confirm a change landed.

## List Of Commands

_psRadiantOne_ currently ships 364 commands, grouped into the areas below. The full list is not reproduced command-by-command here - instead, once the module is imported:

```powershell
# List every command in the module
Get-Command -Module psRadiantOne

# Get detailed help, including examples, for any command
Get-Help Connect-R1Session -Full
```

Every command also has a corresponding reference page under [`docs/collections/_commands`](docs/collections/_commands), which is the same content `Get-Help` displays.

| Area                            | Covers                                                                                                                  |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Session / Authentication**    | Sign-in & session lifecycle, token renewal & revocation, password reset, ADAP token and caller privilege checks         |
| **Access Tokens**               | Long-lived API access tokens - create, list, remove                                                                     |
| **Users, Roles & Managers**     | FID users & roles, role assignment, the directory manager and special groups                                            |
| **Access Control**              | Access control settings, ACIs, ACI locations and ACI evaluation                                                         |
| **Attribute Encryption**        | Encrypted attributes, KMS settings and encryption key rotation                                                          |
| **Certificates & Validators**   | The client certificate truststore, and external token validators                                                        |
| **OIDC**                        | OIDC providers, login info, discovery endpoints and scope claims                                                        |
| **Password Policies**           | Policies, the password dictionary, password encryption and strength rule testing                                        |
| **Audit & Logging**             | Audit log settings and export, component/data source/plugin log settings, log timezone                                  |
| **Client Access & Limits**      | LDAP & REST client access and mappings, global, backend, custom and access regulation limits                            |
| **Global Namespace**            | Global interception settings, special attributes and dynamic groups                                                     |
| **Naming Contexts**             | Naming contexts and children, labels, content, containers & links, enable/disable, virtual & relationship trees         |
| **Namespace Utilities & Views** | LDAP filter, computed attribute and join condition validation; dynamic group formats; namespace views                   |
| **Interception Scripts**        | Interception scripts & libraries, global scripts, script code testing and jar creation                                  |
| **Directory Schema**            | Object classes, attributes, attribute syntaxes and schema files                                                         |
| **Directory Browser**           | Entry CRUD, rename & move, password reset, group membership, saved searches, LDIF import/export, authentication testing |
| **Schemas**                     | Schema CRUD, full-object updates, tables, fields, relationships, derived views, publishing and schema diffs             |
| **Data Sources**                | Data source CRUD, copy, search, connection testing, objects, tables, groups, schema links, import/export                |
| **Data Source Types & Plugins** | Type CRUD & testing, plugins, plugin libraries & classes, template import sessions and metadata                         |
| **Libraries & JDBC Drivers**    | Library CRUD, search, dependencies & dependents; JDBC driver files and libraries                                        |
| **Data Migration & Preview**    | Migration plans, status, logs and exports; LDAP data preview without creating a schema                                  |
| **Tasks**                       | The task scheduler, task CRUD, start/stop, custom tasks and task logs                                                   |
| **Promotion & File Manager**    | Promotion state & settings, staging, configuration export/import & reports; file manager directories, files and jars    |
| **Observability**               | Identity observability pipeline connectors, configuration, suspend/resume and connector scripts                         |
| **Platform & Deployment**       | Product version, service summary, dashboards, SaaS configuration, control panel configuration & messages, features      |
| **Licensing**                   | License read, retrieval and update                                                                                      |
| **Entry Statistics**            | Statistics operations - create, stop, resume - and the statistics they produce                                          |

## Help Us Test

Prior to a 1.0.0 release, 38 of the 364 commands have not yet been exercised against a live deployment: their behaviour rests on the vendor's published API definition alone. What is left is what a test run can't reach on its own - migration and promotion, licensing, jar, library and private-file uploads, schema and directory-schema edits. Each of those commands says so in the `NOTES` section of its help.

To list them:

```powershell
Get-Command -Module psRadiantOne | Where-Object {
    (Get-Help $_.Name).alertSet.alert.Text -match 'not been exercised'
} | Select-Object -ExpandProperty Name
```

If you're able to try one of these against your own deployment, [open an issue][new-issue] with what you found - works as-is, needs a fix, or the request shape is wrong. It's genuinely the fastest way to move a command from "should work" to "confirmed".

## Installation

### Prerequisites

- Requires PowerShell Core (recommended), or Windows PowerShell (version 5.1)
- A RadiantOne deployment or SaaS tenant
- An account with permission to access the RadiantOne API

### Install Options

Users can install psRadiantOne from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name psRadiantOne -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `psRadiantOne`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psRadiantOne/):
  - Run the PowerShell command `Save-Module -Name psRadiantOne -Path C:\temp`
  - Copy the `C:\temp\psRadiantOne` folder to your "Powershell Modules" directory of choice.

##### psRadiantOne Release

- [Download the latest GitHub release](https://github.com/pspete/psRadiantOne/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psRadiantOne-v#.#.#` folder to `psRadiantOne`
  - Copy the `psRadiantOne` folder to your "Powershell Modules" directory of choice.

##### psRadiantOne Branch

- [Download the `main` branch](https://github.com/pspete/psRadiantOne/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `psRadiantOne` (`\<Archive Root>\psRadiantOne-main\psRadiantOne`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable psRadiantOne

```

Import the module:

```powershell

Import-Module psRadiantOne

```

List Module Commands:

```powershell

Get-Command -Module psRadiantOne

```

Get detailed information on specific commands:

```powershell

Get-Help Connect-R1Session -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_psRadiantOne_ is neither developed nor supported by Radiant Logic; any official support channels offered by the vendor are not appropriate for seeking help with the _psRadiantOne_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/psRadiantOne/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.

![Logo][Logo]
