---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Stop-R1Task

## SYNOPSIS
Terminates a running task.

## SYNTAX

```
Stop-R1Task [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Terminates a task which is running.

## EXAMPLES

### Example 1
```powershell
Stop-R1Task -id 'e4ef6b3e'
```

Terminates the task, after prompting for confirmation.

### Example 2
```powershell
Get-R1Task | Where-Object status -eq 'RUNNING' | Stop-R1Task
```

Terminates every running task.

## PARAMETERS

### -id
The identifier of the task.

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

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1Task](Get-R1Task)

[Start-R1Task](Start-R1Task)
