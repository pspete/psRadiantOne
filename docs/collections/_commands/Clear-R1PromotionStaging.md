---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Clear-R1PromotionStaging

## SYNOPSIS
Unstages the resources staged for export.

## SYNTAX

```
Clear-R1PromotionStaging [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Discards the staged resources and returns the promotion state to inactive.

## EXAMPLES

### Example 1
```powershell
Clear-R1PromotionStaging
```

Unstages everything, after prompting for confirmation.

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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Start-R1PromotionStaging](Start-R1PromotionStaging)

[Get-R1PromotionState](Get-R1PromotionState)
