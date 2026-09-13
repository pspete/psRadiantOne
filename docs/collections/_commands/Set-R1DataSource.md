---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DataSource

## SYNOPSIS
Updates a data source.

## SYNTAX

```
Set-R1DataSource [-name] <String> [[-active] <Boolean>] [[-description] <String>] [[-defaultSchema] <String>]
 [[-addedSchemas] <String[]>] [[-hostName] <String>] [[-port] <Int32>] [[-ssl] <Boolean>] [[-bindDn] <String>]
 [[-baseDn] <String>] [[-url] <String>] [[-username] <String>] [[-customProps] <Hashtable>]
 [[-password] <SecureString>] [-useExistingCredentials] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a data source.

The current data source is retrieved and sent back with the supplied values applied over it, so a
property left unspecified keeps its current value. Because the shape differs between LDAP,
database and custom sources, the request is built from what the API returned rather than from a
fixed list of properties.

The request body is sent as UTF8 bytes so that a supplied password cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Set-R1DataSource -name 'opendj' -description 'Corporate directory'
```

Changes the description, leaving every other property as it is.

### Example 2
```powershell
Set-R1DataSource -name 'opendj' -password $Secret
```

Changes the bind password.

### Example 3
```powershell
Set-R1DataSource -name 'opendj' -hostName 'ldap2.example.com' -useExistingCredentials
```

Moves the data source to another host, telling the server to keep the stored credentials.

## PARAMETERS

### -name
The name of the data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 2
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
Position: 3
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
Position: 4
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
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -hostName
The host of the directory server. The API property is host, which cannot be used as a parameter name because it is a PowerShell automatic variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: host

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -port
The port of the directory server.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ssl
Whether the connection uses SSL.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bindDn
The DN used to bind to the directory server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
The base DN of the data read from the directory server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -url
The JDBC URL of the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -username
The account used to connect to the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -customProps
The properties of a custom data source, as a hashtable of names to values.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
The password used to authenticate. Supply it only to set or change it.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useExistingCredentials
Tells the server to keep every stored password, whatever the request body carries.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

The API does not return the bind password: a data source that has one reads back an empty string,
and one that has none reads back null. Sending that empty string back would be read as an
instruction to clear the password, so this command sends null instead, which the API documents as
leaving the stored password alone. Supply -password only to change it.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[New-R1DataSource](New-R1DataSource)
