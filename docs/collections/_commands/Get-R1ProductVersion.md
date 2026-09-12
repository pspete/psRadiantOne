---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ProductVersion

## SYNOPSIS
Returns the product version.

## SYNTAX

```
Get-R1ProductVersion [<CommonParameters>]
```

## DESCRIPTION
Returns the RadiantOne product version, its install date and, where the licence carries one, its
expiry date.

## EXAMPLES

### Example 1
```powershell
Get-R1ProductVersion
```

Returns the product version.

### Example 2
```powershell
(Get-R1ProductVersion).version
```

Returns just the version string.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ProductVersion

## NOTES

## RELATED LINKS
