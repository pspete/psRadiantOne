---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PasswordEncryption

## SYNOPSIS
Returns the available password encryption algorithms.

## SYNTAX

```
Get-R1PasswordEncryption [<CommonParameters>]
```

## DESCRIPTION
Returns the password hashing algorithms the deployment supports, which are the values accepted by
the passwordEncryptionAlgorithm setting of a password policy.

## EXAMPLES

### Example 1
```powershell
Get-R1PasswordEncryption
```

Returns the available algorithms.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
