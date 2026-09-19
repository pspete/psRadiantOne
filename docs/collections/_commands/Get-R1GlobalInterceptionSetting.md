---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1GlobalInterceptionSetting

## SYNOPSIS
Returns the global interception settings.

## SYNTAX

```
Get-R1GlobalInterceptionSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the settings governing the global interception script, including the Java class which
implements it and the operations it is invoked before and after.

## EXAMPLES

### Example 1
```powershell
Get-R1GlobalInterceptionSetting
```

Returns the global interception settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.GlobalInterceptionSettings

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Set-R1GlobalInterceptionSetting](Set-R1GlobalInterceptionSetting)
