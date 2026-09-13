---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1GeneratedSchema

## SYNOPSIS
Generates schemas.

## SYNTAX

```
New-R1GeneratedSchema [-schemaName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates the server schema for the named schemas. Names may be supplied as an array or through
the pipeline, and are collected into a single request.

## EXAMPLES

### Example 1
```powershell
New-R1GeneratedSchema -schemaName 'sales'
```

Generates the server schema for the sales schema.

### Example 2
```powershell
Get-R1Schema | Select-Object -ExpandProperty name | New-R1GeneratedSchema
```

Generates the server schema for every schema in the catalog, in one request.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1Schema](Get-R1Schema)

[Publish-R1Schema](Publish-R1Schema)
