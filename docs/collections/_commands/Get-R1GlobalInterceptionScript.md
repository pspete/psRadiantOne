---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/Get-R1GlobalInterceptionScript
schema: 2.0.0
title: Get-R1GlobalInterceptionScript
category: Interception Scripts
---

# Get-R1GlobalInterceptionScript

## SYNOPSIS
Returns the global interception script.

## SYNTAX

```
Get-R1GlobalInterceptionScript [<CommonParameters>]
```

## DESCRIPTION
Returns the contents of the global interception script, together with its class and file name.

## EXAMPLES

### Example 1
```powershell
Get-R1GlobalInterceptionScript
```

Returns the global interception script.

### Example 2
```powershell
(Get-R1GlobalInterceptionScript).scriptContents | Set-Content .\globalIntercept.java
```

Saves the global interception script to a local file.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.InterceptionScriptContents

## NOTES

## RELATED LINKS

[Set-R1GlobalInterceptionScript](Set-R1GlobalInterceptionScript)

[Get-R1GlobalInterceptionSetting](Get-R1GlobalInterceptionSetting)
