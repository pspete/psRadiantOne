---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1TaskScheduler

## SYNOPSIS
Returns the task scheduler settings.

## SYNTAX

```
Get-R1TaskScheduler [<CommonParameters>]
```

## DESCRIPTION
Returns the settings of the task scheduler, together with whether it is running and the log
levels in force.

## EXAMPLES

### Example 1
```powershell
Get-R1TaskScheduler
```

Returns the task scheduler settings.

### Example 2
```powershell
(Get-R1TaskScheduler).status
```

Returns whether the scheduler is running.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.TaskScheduler

## NOTES

## RELATED LINKS

[Set-R1TaskScheduler](Set-R1TaskScheduler)

[Start-R1TaskScheduler](Start-R1TaskScheduler)

[Stop-R1TaskScheduler](Stop-R1TaskScheduler)
