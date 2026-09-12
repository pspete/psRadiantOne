---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Read-R1License

## SYNOPSIS
Reports what a license contains without applying it.

## SYNTAX

```
Read-R1License [-license] <String> [<CommonParameters>]
```

## DESCRIPTION
Reads a license and returns the type, product, expiry and validity it carries, without applying it
to the deployment.

This command has not been exercised against a live deployment. The license endpoint returned 404 on the RadiantOne SaaS tenant available for testing, where licensing appears to be handled through the environment operations center rather than this API.

## EXAMPLES

### Example 1
```powershell
Read-R1License -license $licenseKey
```

Reports what the license contains.

### Example 2
```powershell
Read-R1License -license (Get-Content .\radiantone.lic -Raw)
```

Reads a license from a file.

## PARAMETERS

### -license
The license key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.LicenseInfo

## NOTES

## RELATED LINKS
