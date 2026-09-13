---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PromotionStagedResource

## SYNOPSIS
Returns the resources staged for export.

## SYNTAX

```
Get-R1PromotionStagedResource [<CommonParameters>]
```

## DESCRIPTION
Returns the resources staging found, grouped by kind: naming contexts, data sources, settings,
jars, sync topologies and connectors.

## EXAMPLES

### Example 1
```powershell
Get-R1PromotionStagedResource
```

Returns everything staged for export.

### Example 2
```powershell
(Get-R1PromotionStagedResource).namingContexts
```

Returns just the staged naming contexts.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.StagedResources

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Start-R1PromotionStaging](Start-R1PromotionStaging)

[Test-R1PromotionStagedResource](Test-R1PromotionStagedResource)

[Export-R1Configuration](Export-R1Configuration)
