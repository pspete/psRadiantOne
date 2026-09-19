---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PasswordDictionary

## SYNOPSIS
Returns the password dictionary words.

## SYNTAX

```
Get-R1PasswordDictionary [<CommonParameters>]
```

## DESCRIPTION
Returns the words held in the password dictionary. Where a policy enables dictionary checking,
passwords matching these words are rejected.

## EXAMPLES

### Example 1
```powershell
Get-R1PasswordDictionary
```

Returns every word in the password dictionary.

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
