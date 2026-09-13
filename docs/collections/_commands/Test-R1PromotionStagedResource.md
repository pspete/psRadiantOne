---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1PromotionStagedResource

## SYNOPSIS
Validates a selection of staged resources.

## SYNTAX

```
Test-R1PromotionStagedResource [-StagedResources] <Object> [<CommonParameters>]
```

## DESCRIPTION
Checks that a selection of staged resources can be promoted together, which means every required
dependency is present. Nothing is exported.

## EXAMPLES

### Example 1
```powershell
$Staged = Get-R1PromotionStagedResource
Test-R1PromotionStagedResource -StagedResources $Staged
```

Validates everything that was staged.

## PARAMETERS

### -StagedResources
The staged resources to validate, as returned by Get-R1PromotionStagedResource.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.StagedPromotionResourceValidationResult

## NOTES

The promotion state must be staged export, and every resource passed must be among those staged,
or the request fails.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1PromotionStagedResource](Get-R1PromotionStagedResource)

[Export-R1Configuration](Export-R1Configuration)
