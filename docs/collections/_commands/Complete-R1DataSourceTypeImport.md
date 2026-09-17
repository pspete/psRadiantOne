---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Complete-R1DataSourceTypeImport

## SYNOPSIS
Imports templates from an upload session.

## SYNTAX

```
Complete-R1DataSourceTypeImport [-id] <String> [-templates] <String[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Imports the named templates from an upload session, making them available as data source types.

## EXAMPLES

### Example 1
```powershell
Complete-R1DataSourceTypeImport -id 'imp1' -templates 'My Custom'
```

Imports one template.

### Example 2
```powershell
Complete-R1DataSourceTypeImport -id 'imp1' -templates 'My Custom', 'My Other'
```

Imports two templates in a single request.

## PARAMETERS

### -id
The identifier of the upload session, as returned by Import-R1DataSourceType.

```yaml
Type: String
Parameter Sets: (All)
Aliases: importId

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -templates
The names of the templates.

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

## RELATED LINKS

[Import-R1DataSourceType](Import-R1DataSourceType)

[Get-R1DataSourceTypeImportMeta](Get-R1DataSourceTypeImportMeta)
