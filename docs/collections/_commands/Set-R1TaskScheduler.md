---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1TaskScheduler

## SYNOPSIS
Updates the task scheduler settings.

## SYNTAX

```
Set-R1TaskScheduler [[-defaultJvmParameters] <String>] [[-deleteTasksOlderThanDays] <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the settings of the task scheduler.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value.

## EXAMPLES

### Example 1
```powershell
Set-R1TaskScheduler -deleteTasksOlderThanDays 30
```

Keeps a month of finished tasks, leaving the JVM parameters as they are.

### Example 2
```powershell
Set-R1TaskScheduler -defaultJvmParameters '-server -Xms1024m'
```

Changes the default JVM parameters used by tasks.

## PARAMETERS

### -defaultJvmParameters
The JVM parameters used by tasks which do not set their own.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -deleteTasksOlderThanDays
How many days of finished tasks are kept before they are removed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.TaskScheduler

## NOTES

The running state and the log levels are reported by the scheduler but are not part of the
update, so they are not sent. Use the start, stop and restart commands to change the running
state.

## RELATED LINKS

[Get-R1TaskScheduler](Get-R1TaskScheduler)

[Restart-R1TaskScheduler](Restart-R1TaskScheduler)
