---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ChangeLogSetting

## SYNOPSIS
Returns the change log settings.

## SYNTAX

```
Get-R1ChangeLogSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the change log settings, covering whether the change log is enabled, how long entries are
retained, and the per-backend change log entries.

## EXAMPLES

### Example 1
```powershell
Get-R1ChangeLogSetting
```

Returns the change log settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ChangeLogSettings

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
