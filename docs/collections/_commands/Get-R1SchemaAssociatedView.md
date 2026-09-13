---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaAssociatedView

## SYNOPSIS
Returns the views associated with a schema.

## SYNTAX

```
Get-R1SchemaAssociatedView [-schemaName] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the name of every view built on the named schema.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaAssociatedView -schemaName 'default'
```

Returns the views associated with the default schema.

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

### System.String

## NOTES

A schema with no views associated with it returns nothing.

## RELATED LINKS

[Get-R1Schema](Get-R1Schema)
