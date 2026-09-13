---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1Schema

## SYNOPSIS
Updates the properties of a schema.

## SYNTAX

```
Set-R1Schema [-schemaName] <String> [[-type] <String>] [[-dataSourceName] <String>] [[-baseDn] <String>]
 [[-publishToServer] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the properties of a schema in the data catalog.

The current definition is retrieved before it is updated, and sent back with the supplied values
applied over it, so a property left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the definition as well
as to change it.

## EXAMPLES

### Example 1
```powershell
Set-R1Schema -schemaName 'sales' -publishToServer $true
```

Publishes the sales schema to the server, leaving its other properties as they are.

### Example 2
```powershell
Set-R1Schema -schemaName 'sales' -baseDn 'o=sales'
```

Changes the base DN of the sales schema.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Whether the schema is built from an LDAP source, a database source, or defined by hand.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSourceName
The name of the data source the schema reads from.

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

### -baseDn
The base DN the schema reads from.

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

### -publishToServer
Whether the schema is published to the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

The last modified time is maintained by the server and is sent back unaltered so that the update
carries the complete resource. The list of selected objects applies only when a schema is created
and is not sent on update, as the API documents.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1Schema](Get-R1Schema)

[Set-R1SchemaFullObject](Set-R1SchemaFullObject)
