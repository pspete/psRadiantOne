---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/Get-R1CustomLimit
schema: 2.0.0
title: Get-R1CustomLimit
category: Limits
---

# Get-R1CustomLimit

## SYNOPSIS
Returns the custom limits.

## SYNTAX

```
Get-R1CustomLimit [<CommonParameters>]
```

## DESCRIPTION
Returns the custom limits, which cap connections, search size, idle time and operation time for a
subtree, a group, anonymous users or authenticated users.

## EXAMPLES

### Example 1
```powershell
Get-R1CustomLimit
```

Returns the custom limits.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.CustomLimit

## NOTES

## RELATED LINKS
