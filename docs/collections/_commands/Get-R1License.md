---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1License

## SYNOPSIS
Returns the license details.

## SYNTAX

```
Get-R1License [<CommonParameters>]
```

## DESCRIPTION
Returns the license type, the product it covers, its expiry date and whether it is valid.

This command has not been exercised against a live deployment. The license endpoint returned 404 on the RadiantOne SaaS tenant available for testing, where licensing appears to be handled through the environment operations center rather than this API.

## EXAMPLES

### Example 1
```powershell
Get-R1License
```

Returns the license details.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.LicenseInfo

## NOTES

## RELATED LINKS
