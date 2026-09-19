---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1CallerPrivilege

## SYNOPSIS
Reports whether the authenticated caller has privileged access.

## SYNTAX

```
Test-R1CallerPrivilege [<CommonParameters>]
```

## DESCRIPTION
Returns whether the authenticated caller has privileged access, as determined by the API from the
username claim in the authentication token.

## EXAMPLES

### Example 1
```powershell
Test-R1CallerPrivilege
```

Returns true when the authenticated caller has privileged access.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS
