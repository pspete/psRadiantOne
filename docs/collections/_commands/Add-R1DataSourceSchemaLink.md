---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Add-R1DataSourceSchemaLink

## SYNOPSIS
Links a schema to a data source.

## SYNTAX

### Single (Default)
```
Add-R1DataSourceSchemaLink -name <String> -schemaName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Add-R1DataSourceSchemaLink -schemaNames <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Links a schema to a named data source, or links a set of schemas to whichever data sources they
belong to. The names of the data sources that changed are returned.

## EXAMPLES

### Example 1
```powershell
Add-R1DataSourceSchemaLink -name 'opendj' -schemaName 'default'
```

Links the default schema to opendj.

### Example 2
```powershell
Add-R1DataSourceSchemaLink -schemaNames 'default', 'sales'
```

Links two schemas in a single request.

## PARAMETERS

### -name
The name of the data source.

```yaml
Type: String
Parameter Sets: Single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: Single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -schemaNames
The names of the schemas to link.

```yaml
Type: String[]
Parameter Sets: Bulk
Aliases:

Required: True
Position: Named
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

### System.String

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Remove-R1DataSourceSchemaLink](Remove-R1DataSourceSchemaLink)

[Get-R1Schema](Get-R1Schema)
