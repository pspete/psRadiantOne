---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1RestClientAccess

## SYNOPSIS
Returns the REST client access settings.

## SYNTAX

```
Get-R1RestClientAccess [<CommonParameters>]
```

## DESCRIPTION
Returns the REST service settings, covering token and cookie lifetimes, the request thread limit, and
whether the service is enabled.

## EXAMPLES

### Example 1
```powershell
Get-R1RestClientAccess
```

Returns the REST client access settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.RestClientAccess

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
