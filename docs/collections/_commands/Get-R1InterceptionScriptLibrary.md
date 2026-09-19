---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1InterceptionScriptLibrary

## SYNOPSIS
Returns the names of the external libraries available to interception scripts.

## SYNTAX

```
Get-R1InterceptionScriptLibrary [<CommonParameters>]
```

## DESCRIPTION
Returns the name of every external library jar uploaded for use by interception scripts.

## EXAMPLES

### Example 1
```powershell
Get-R1InterceptionScriptLibrary
```

Returns the name of every external library.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Import-R1InterceptionScriptLibrary](Import-R1InterceptionScriptLibrary)

[Remove-R1InterceptionScriptLibrary](Remove-R1InterceptionScriptLibrary)
