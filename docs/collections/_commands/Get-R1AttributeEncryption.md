---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AttributeEncryption

## SYNOPSIS
Returns the attribute encryption settings.

## SYNTAX

```
Get-R1AttributeEncryption [<CommonParameters>]
```

## DESCRIPTION
Returns the attribute encryption settings, including the ciphers in use, whether encryption keys
exist, and the ciphers available to choose from.

## EXAMPLES

### Example 1
```powershell
Get-R1AttributeEncryption
```

Returns the attribute encryption settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.AttributeEncryption

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
