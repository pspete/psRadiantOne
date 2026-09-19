---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Dashboard

## SYNOPSIS
Returns the dashboard widgets.

## SYNTAX

```
Get-R1Dashboard [<CommonParameters>]
```

## DESCRIPTION
Returns the widgets shown on the control panel dashboard, with their type, source URL and layout.

## EXAMPLES

### Example 1
```powershell
Get-R1Dashboard
```

Returns the dashboard widgets.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DashboardItem

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
