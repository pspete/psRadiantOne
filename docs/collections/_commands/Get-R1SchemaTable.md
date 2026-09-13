---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaTable

## SYNOPSIS
Returns the tables and views of a schema.

## SYNTAX

### All (Default)
```
Get-R1SchemaTable -schemaName <String> [<CommonParameters>]
```

### TableName
```
Get-R1SchemaTable -schemaName <String> -tableName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every table and view in the schema, or a single one when it is named.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaTable -schemaName 'default'
```

Returns every table and view in the default schema.

### Example 2
```powershell
Get-R1SchemaTable -schemaName 'default' -tableName 'APP.CUSTOMERS'
```

Returns the APP.CUSTOMERS table.

### Example 3
```powershell
Get-R1SchemaTable -schemaName 'default' | Where-Object { -not $PSItem.isTable }
```

Returns only the views of the schema.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tableName
The name of the table or view.

```yaml
Type: String
Parameter Sets: TableName
Aliases:

Required: True
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

### psRadiantOne.Table

## NOTES

## RELATED LINKS

[New-R1SchemaTable](New-R1SchemaTable)

[Set-R1SchemaTable](Set-R1SchemaTable)

[Remove-R1SchemaTable](Remove-R1SchemaTable)

[Get-R1SchemaTableField](Get-R1SchemaTableField)
