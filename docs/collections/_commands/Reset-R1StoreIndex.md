---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Reset-R1StoreIndex

## SYNOPSIS
Rebuilds the index of a RadiantOne Directory store.

## SYNTAX

```
Reset-R1StoreIndex [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a task rebuilding the index of the RadiantOne Directory store mounted at the naming context
node, and returns the id of the task.

## EXAMPLES

### Example 1
```powershell
$Task = Reset-R1StoreIndex -dn 'o=store'
Get-R1TaskLog -id $Task.taskId -numberOfLines 15
```

Rebuilds the index and shows the end of the log of the task doing it.

## PARAMETERS

### -dn
The DN of the store.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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

### psRadiantOne.LaunchedTask

## NOTES

A store has one rebuild task, whose id is the same each time. A rebuild requested while that task is
still running is refused with "Failed to launch rebuild index task"; wait for it to finish first.

## RELATED LINKS

[Set-R1StoreProperty](Set-R1StoreProperty)

[Get-R1TaskLog](Get-R1TaskLog)
