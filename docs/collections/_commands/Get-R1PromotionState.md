---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PromotionState

## SYNOPSIS
Returns the configuration promotion state.

## SYNTAX

```
Get-R1PromotionState [<CommonParameters>]
```

## DESCRIPTION
Returns where the configuration promotion process currently stands, which governs what the other
promotion commands will accept.

## EXAMPLES

### Example 1
```powershell
Get-R1PromotionState
```

Returns the promotion state.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.PromotionState

## NOTES

## RELATED LINKS

[Start-R1PromotionStaging](Start-R1PromotionStaging)

[Get-R1PromotionStagedResource](Get-R1PromotionStagedResource)

[Export-R1Configuration](Export-R1Configuration)
