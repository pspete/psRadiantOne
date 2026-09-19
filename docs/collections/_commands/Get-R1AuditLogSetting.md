---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AuditLogSetting

## SYNOPSIS
Returns the audit logging configuration.

## SYNTAX

```
Get-R1AuditLogSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the audit logging configuration, covering whether auditing is enabled, whether the
differences made by a change are recorded, and whether the log is written in JSON.

## EXAMPLES

### Example 1
```powershell
Get-R1AuditLogSetting
```

Returns the audit logging configuration.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.AuditLogConfiguration

## NOTES

## RELATED LINKS
