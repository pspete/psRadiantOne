---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Feature

## SYNOPSIS
Returns feature flags.

## SYNTAX

### All (Default)
```
Get-R1Feature [<CommonParameters>]
```

### FlagId
```
Get-R1Feature -flagId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the feature flags and their current values. Specify a flag id to return a single flag.

## EXAMPLES

### Example 1
```powershell
Get-R1Feature
```

Returns every feature flag.

### Example 2
```powershell
Get-R1Feature -flagId someFeature
```

Returns a single feature flag.

## PARAMETERS

### -flagId
The identifier of the feature flag.

```yaml
Type: String
Parameter Sets: FlagId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.FeatureFlag

## NOTES

## RELATED LINKS
