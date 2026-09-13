---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaTableField

## SYNOPSIS
Returns the fields of a table.

## SYNTAX

```
Get-R1SchemaTableField [-schemaName] <String> [-tableName] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every field of the named table, with the attribute each maps to and its type.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaTableField -schemaName 'default' -tableName 'APP.CUSTOMERS'
```

Returns the fields of the APP.CUSTOMERS table.

### Example 2
```powershell
Get-R1SchemaTableField -schemaName 'default' -tableName 'APP.CUSTOMERS' | Where-Object primaryKey
```

Returns only the primary key fields.

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

### -tableName
The name of the table or view.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Field

## NOTES

## RELATED LINKS

[Set-R1SchemaTableField](Set-R1SchemaTableField)

[Get-R1SchemaTable](Get-R1SchemaTable)
