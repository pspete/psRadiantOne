---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Session

## SYNOPSIS
Returns the details of the current RadiantOne session.

## SYNTAX

```
Get-R1Session [<CommonParameters>]
```

## DESCRIPTION
Returns a copy of the module scope session, holding the base URL, the authenticated user, the
authentication token and its expiry, the privileges granted by the token, and details of the last
command issued and the last error encountered.

The returned object is a copy; modifying it does not alter the session used by other commands.

## EXAMPLES

### Example 1
```powershell
Get-R1Session
```

Returns the details of the current session.

### Example 2
```powershell
(Get-R1Session).Privileges
```

Returns the privileges granted by the current authentication token.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Session

## NOTES

## RELATED LINKS
