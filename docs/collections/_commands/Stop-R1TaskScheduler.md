---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Stop-R1TaskScheduler

## SYNOPSIS
Stops the task scheduler.

## SYNTAX

```
Stop-R1TaskScheduler [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stops the task scheduler. Scheduled tasks do not run while it is stopped.

## EXAMPLES

### Example 1
```powershell
Stop-R1TaskScheduler
```

Stops the scheduler, after prompting for confirmation.

## PARAMETERS

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

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Start-R1TaskScheduler](Start-R1TaskScheduler)

[Restart-R1TaskScheduler](Restart-R1TaskScheduler)
