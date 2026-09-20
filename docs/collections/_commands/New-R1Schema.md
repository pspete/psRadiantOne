---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1Schema

## SYNOPSIS
Creates a schema.

## SYNTAX

```
New-R1Schema [-name] <String> [-type] <String> [-dataSourceName] <String> [[-baseDn] <String>]
 [[-publishToServer] <Boolean>] [[-objects] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a schema in the data catalog against the named data source.

The tables and views to include are given by objects, which is used only when the schema is
created. Leave it unset for a custom schema.

## EXAMPLES

### Example 1
```powershell
New-R1Schema -name 'sales' -type 'DATABASE' -dataSourceName 'advworks' -objects 'APP.CUSTOMERS', 'APP.ORDERS'
```

Creates a database schema over two tables of the advworks data source.

### Example 2
```powershell
New-R1Schema -name 'handmade' -type 'CUSTOM' -dataSourceName 'advworks'
```

Creates a custom schema, whose contents are defined afterwards.

## PARAMETERS

### -name
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: schemaName

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

Required: True
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

Required: True
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

### -objects
The tables and views to include when the schema is created. Not sent when a schema is updated.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

The data source must be reachable when the schema is created.

The schema is linked to the data source on creation. Remove-R1DataSourceSchemaLink removes the link.

## RELATED LINKS

[Get-R1Schema](Get-R1Schema)

[Set-R1Schema](Set-R1Schema)
