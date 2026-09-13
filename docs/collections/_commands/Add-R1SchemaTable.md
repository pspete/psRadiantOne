---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Add-R1SchemaTable

## SYNOPSIS
Appends tables to a schema by name.

## SYNTAX

```
Add-R1SchemaTable [-schemaName] <String> [-tableName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Appends existing tables of the data source to the schema, given only their names. Several may be
appended in one request.

## EXAMPLES

### Example 1
```powershell
Add-R1SchemaTable -schemaName 'default' -tableName 'APP.ORDERS'
```

Appends one table to the schema.

### Example 2
```powershell
Add-R1SchemaTable -schemaName 'default' -tableName 'APP.ORDERS', 'APP.INVOICES'
```

Appends two tables in a single request.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: schema

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tableName
The name of the table or view.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: name

Required: True
Position: 2
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

This appends to the schema, unlike the other collection commands, which replace. Use
New-R1SchemaTable to add a table whose properties need to be described.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[New-R1SchemaTable](New-R1SchemaTable)

[Get-R1SchemaTable](Get-R1SchemaTable)
