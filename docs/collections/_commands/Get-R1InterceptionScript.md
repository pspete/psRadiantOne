---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1InterceptionScript

## SYNOPSIS
Returns the names of the interception scripts on the server.

## SYNTAX

```
Get-R1InterceptionScript [<CommonParameters>]
```

## DESCRIPTION
Returns the name of every interception script held on the server.

## EXAMPLES

### Example 1
```powershell
Get-R1InterceptionScript
```

Returns the name of every interception script on the server.

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

[Import-R1InterceptionScript](Import-R1InterceptionScript)

[Remove-R1InterceptionScript](Remove-R1InterceptionScript)
