---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Restart-R1TaskScheduler

## SYNOPSIS
Restarts the task scheduler.

## SYNTAX

```
Restart-R1TaskScheduler [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stops and starts the task scheduler in one operation.

## EXAMPLES

### Example 1
```powershell
Restart-R1TaskScheduler
```

Restarts the scheduler, after prompting for confirmation.

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

## RELATED LINKS

[Start-R1TaskScheduler](Start-R1TaskScheduler)

[Stop-R1TaskScheduler](Stop-R1TaskScheduler)
