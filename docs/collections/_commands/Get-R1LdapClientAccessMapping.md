---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LdapClientAccessMapping

## SYNOPSIS
Returns the LDAP user to DN mappings.

## SYNTAX

```
Get-R1LdapClientAccessMapping [<CommonParameters>]
```

## DESCRIPTION
Returns the mappings from user id to DN used by LDAP client access.

## EXAMPLES

### Example 1
```powershell
Get-R1LdapClientAccessMapping
```

Returns the user to DN mappings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.UserToDnMapping

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
