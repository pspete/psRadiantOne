---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1Task

## SYNOPSIS
Updates a scheduled task.

## SYNTAX

```
Set-R1Task [-id] <String> [[-dedicatedJvm] <Boolean>] [[-jvmParameters] <String>]
 [[-executionInterval] <String>] [[-name] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a task.

The task is retrieved before it is updated, and sent back with the supplied values applied over
it, so a property left unspecified keeps its current value.

## EXAMPLES

### Example 1
```powershell
Set-R1Task -id 'e4ef6b3e' -executionInterval '00h 05m 00s'
```

Runs the task every five minutes.

### Example 2
```powershell
Set-R1Task -id 'e4ef6b3e' -dedicatedJvm $true -jvmParameters '-Xms1024m -Xmx1024m'
```

Moves the task into its own JVM with the given parameters.

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

### -dedicatedJvm
Runs the task in a JVM of its own rather than the server process.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jvmParameters
The JVM parameters used when the task runs in a dedicated JVM.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -executionInterval
How often a recurrent task runs, written as hours, minutes and seconds, for example 00h 05m 00s.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the task.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

The status, whether the task is recurrent, its execution times and its log list are reported by
the API but are not part of the update, so they are not sent.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1Task](Get-R1Task)
