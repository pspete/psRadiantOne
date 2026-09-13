---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Publish-R1Schema

## SYNOPSIS
Sets which schemas are published.

## SYNTAX

```
Publish-R1Schema [-schemaName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the set of published schemas with the names supplied. Names may be given as an array or
through the pipeline, and are collected into a single request.

## EXAMPLES

### Example 1
```powershell
Publish-R1Schema -schemaName 'sales', 'default'
```

Publishes exactly these two schemas.

### Example 2
```powershell
Publish-R1Schema -schemaName @()
```

Unpublishes every schema.

### Example 3
```powershell
Get-R1PublishedSchema | Where-Object { $PSItem -ne 'sales' } | Publish-R1Schema
```

Unpublishes the sales schema by publishing everything else.

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

The request body is the complete list of published schemas, so a name left out is unpublished.
Retrieve the current list with Get-R1PublishedSchema and pass back the whole of it to add one.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1PublishedSchema](Get-R1PublishedSchema)
