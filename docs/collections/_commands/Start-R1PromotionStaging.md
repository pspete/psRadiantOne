---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Start-R1PromotionStaging

## SYNOPSIS
Stages resources for export.

## SYNTAX

```
Start-R1PromotionStaging [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Walks the resource graph and works out what is available for promotion, putting the promotion
state into staged export. What it found is then read with Get-R1PromotionStagedResource.

## EXAMPLES

### Example 1
```powershell
Start-R1PromotionStaging
```

Stages resources for export.

### Example 2
```powershell
Start-R1PromotionStaging
Get-R1PromotionState
```

Stages, then checks how far it has got.

## PARAMETERS

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

Staging runs in the background. Watch Get-R1PromotionState rather than assuming the resources
are ready when this returns.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1PromotionStagedResource](Get-R1PromotionStagedResource)

[Clear-R1PromotionStaging](Clear-R1PromotionStaging)

[Get-R1PromotionState](Get-R1PromotionState)
