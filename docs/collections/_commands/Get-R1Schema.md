---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Schema

## SYNOPSIS
Returns the schemas in the data catalog.

## SYNTAX

### All (Default)
```
Get-R1Schema [-includeLinkedSchemas <Boolean>] [<CommonParameters>]
```

### SchemaName
```
Get-R1Schema -schemaName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the name and type of every schema in the data catalog, or the properties of a single
schema when one is named.

## EXAMPLES

### Example 1
```powershell
Get-R1Schema
```

Returns every schema in the catalog.

### Example 2
```powershell
Get-R1Schema -schemaName 'default'
```

Returns the properties of the default schema.

### Example 3
```powershell
Get-R1Schema -includeLinkedSchemas $false
```

Returns the schemas, excluding linked ones.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: SchemaName
Aliases: name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -includeLinkedSchemas
Includes linked schemas in the result.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.SchemaProperties

## NOTES

## RELATED LINKS

[Get-R1SchemaFullObject](Get-R1SchemaFullObject)

[New-R1Schema](New-R1Schema)

[Set-R1Schema](Set-R1Schema)

[Remove-R1Schema](Remove-R1Schema)
