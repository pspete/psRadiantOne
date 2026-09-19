---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1BackendLimit

## SYNOPSIS
Returns the backend limits.

## SYNTAX

```
Get-R1BackendLimit [<CommonParameters>]
```

## DESCRIPTION
Returns the backend connection limits, covering LDAP and JDBC pool sizes, timeouts and the SRV record
lookup limit.

## EXAMPLES

### Example 1
```powershell
Get-R1BackendLimit
```

Returns the backend limits.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.BackendLimits

## NOTES

## RELATED LINKS
