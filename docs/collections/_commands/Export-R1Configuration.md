---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1Configuration

## SYNOPSIS
Exports the deployment configuration.

## SYNTAX

### All (Default)
```
Export-R1Configuration [-force <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Staged
```
Export-R1Configuration [-force <Boolean>] -stagedResources <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Exports the configuration, either in full or limited to a selection of staged resources.

Supplying stagedResources exports only those; without it everything is exported.

## EXAMPLES

### Example 1
```powershell
Export-R1Configuration
```

Exports the whole configuration.

### Example 2
```powershell
$Staged = Get-R1PromotionStagedResource
Export-R1Configuration -stagedResources $Staged
```

Exports only the staged resources.

### Example 3
```powershell
Export-R1Configuration -force $true
```

Exports without validating dependencies first.

## PARAMETERS

### -force
Skips the dependency validation which otherwise runs before the export.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -stagedResources
The staged resources to act on, as returned by Get-R1PromotionStagedResource.

```yaml
Type: Object
Parameter Sets: Staged
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

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1PromotionStagedResource](Get-R1PromotionStagedResource)

[Get-R1ConfigurationExportReport](Get-R1ConfigurationExportReport)

[Import-R1Configuration](Import-R1Configuration)
