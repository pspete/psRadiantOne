---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DataSource

## SYNOPSIS
Creates a data source.

## SYNTAX

### Ldap (Default)
```
New-R1DataSource -name <String> -type <String> [-active <Boolean>] [-description <String>]
 [-defaultSchema <String>] [-addedSchemas <String[]>] [-groupId <String>] -hostName <String> -port <Int32>
 -bindDn <String> [-ssl <Boolean>] [-baseDn <String>] [-pagedResultsControl <Boolean>] [-pageSize <Int32>]
 [-chaseReferrals <Boolean>] [-failovers <Object[]>] [-verifySslHostname <Boolean>] [-kerberosProfile <String>]
 [-sdcMappings <Hashtable>] [-password <SecureString>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Database
```
New-R1DataSource -name <String> -type <String> [-active <Boolean>] [-description <String>]
 [-defaultSchema <String>] [-addedSchemas <String[]>] [-groupId <String>] [-sdcMappings <Hashtable>]
 -driverClassName <String> -url <String> -username <String> [-failOverName <String>] [-onPremHost <String>]
 [-onPremPort <Int32>] [-password <SecureString>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Custom
```
New-R1DataSource -name <String> -type <String> [-active <Boolean>] [-description <String>]
 [-defaultSchema <String>] [-addedSchemas <String[]>] [-groupId <String>] -customProps <Hashtable>
 [-onPremHost <String>] [-onPremPort <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a data source of one of three kinds. Which kind is created is decided by the parameters
supplied: an LDAP source needs a host, port and bind DN; a database source needs a driver class,
URL and username; a custom source needs its custom properties.

The request body is sent as UTF8 bytes so that a supplied password cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
New-R1DataSource -name 'opendj' -type 'Generic LDAP' -hostName 'ldap.example.com' -port 389 -bindDn 'cn=DirectoryManager' -password $Secret
```

Creates an LDAP data source.

### Example 2
```powershell
New-R1DataSource -name 'advworks' -type 'Generic DB' -driverClassName 'org.postgresql.Driver' -url 'jdbc:postgresql://db/adv' -username 'appUser' -password $Secret
```

Creates a database data source.

### Example 3
```powershell
New-R1DataSource -name 'mycustom' -type 'Custom' -customProps @{ url = 'https://example.test' }
```

Creates a custom data source from a set of properties.

## PARAMETERS

### -name
The name of the data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
The data source type, as listed by Get-R1DataSourceType.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -active
Whether the data source is active.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
A description of the data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -defaultSchema
The schema used by default for this data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -addedSchemas
The schemas linked to the data source.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groupId
The group the data source belongs to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -hostName
--------------------------------------------------------------------------------- ldap

```yaml
Type: String
Parameter Sets: Ldap
Aliases: host

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -port
The port of the directory server.

```yaml
Type: Int32
Parameter Sets: Ldap
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bindDn
The DN used to bind to the directory server.

```yaml
Type: String
Parameter Sets: Ldap
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ssl
Whether the connection uses SSL.

```yaml
Type: Boolean
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
The base DN of the data read from the directory server.

```yaml
Type: String
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pagedResultsControl
Whether the paged results control is used when searching.

```yaml
Type: Boolean
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pageSize
The number of entries requested per page.

```yaml
Type: Int32
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -chaseReferrals
Whether referrals returned by the server are followed.

```yaml
Type: Boolean
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -failovers
The failover servers, each with a host, port and ssl setting.

```yaml
Type: Object[]
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -verifySslHostname
Whether the host name on the server certificate is verified.

```yaml
Type: Boolean
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -kerberosProfile
The Kerberos profile used to authenticate.

```yaml
Type: String
Parameter Sets: Ldap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -driverClassName
----------------------------------------------------------------------------- database

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -url
The JDBC URL of the database.

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -username
The account used to connect to the database.

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -failOverName
The name of the failover data source.

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -customProps
------------------------------------------------------------------------------- custom

```yaml
Type: Hashtable
Parameter Sets: Custom
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -onPremHost
------------------------------------------------------------------ database and custom

```yaml
Type: String
Parameter Sets: Database, Custom
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -onPremPort
The port of the on premises connector.

```yaml
Type: Int32
Parameter Sets: Database, Custom
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
-------------------------------------------------------------------- ldap and database

```yaml
Type: SecureString
Parameter Sets: Ldap, Database
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sdcMappings
A map of Secure Data Connector mappings, keyed by name. Each value gives the host and port the
connector reaches the data source on, and optionally the group id.

```yaml
Type: Hashtable
Parameter Sets: Ldap, Database
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[Set-R1DataSource](Set-R1DataSource)

[Test-R1DataSourceConnection](Test-R1DataSourceConnection)
