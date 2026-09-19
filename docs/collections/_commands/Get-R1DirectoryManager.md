---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryManager

## SYNOPSIS
Returns the directory manager settings.

## SYNTAX

```
Get-R1DirectoryManager [<CommonParameters>]
```

## DESCRIPTION
Returns the directory manager settings, including the directory manager username and the list of IP
addresses permitted to bind as the directory manager.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryManager
```

Returns the directory manager settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DirectoryManager

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
