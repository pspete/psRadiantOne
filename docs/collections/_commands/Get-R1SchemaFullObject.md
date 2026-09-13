---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaFullObject

## SYNOPSIS
Returns a schema with its tables, fields and relationships.

## SYNTAX

```
Get-R1SchemaFullObject [-schemaName] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the complete schema: its properties together with every table, the fields of each table,
and the relationships between them. This is the form the control panel works with.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaFullObject -schemaName 'default'
```

Returns the complete default schema.

### Example 2
```powershell
(Get-R1SchemaFullObject -schemaName 'default').tablesWithFields.name
```

Returns the name of every table in the schema.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.SchemaComplete

## NOTES

## RELATED LINKS

[Get-R1Schema](Get-R1Schema)

[Set-R1SchemaFullObject](Set-R1SchemaFullObject)
