---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1TaskLog

## SYNOPSIS
Returns the log of a task.

## SYNTAX

### Download (Default)
```
Get-R1TaskLog -id <String> [<CommonParameters>]
```

### Tail
```
Get-R1TaskLog -id <String> [-Tail] [-TimeoutSec <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns the log a task has written. With -Tail the log is followed as it is written instead.

The tail endpoint does not close the response when it reaches the end of the log: it stays open
waiting for more. The command therefore bounds the request with a timeout and returns what
arrived within it. Without -Tail no timeout is applied, because the log download completes on
its own.

## EXAMPLES

### Example 1
```powershell
Get-R1TaskLog -id 'e4ef6b3e'
```

Returns the log the task has written so far.

### Example 2
```powershell
Get-R1TaskLog -id 'e4ef6b3e' -Tail
```

Follows the log for thirty seconds and returns what arrived.

### Example 3
```powershell
Get-R1TaskLog -id 'e4ef6b3e' -Tail -TimeoutSec 5
```

Follows the log for five seconds.

## PARAMETERS

### -id
The identifier of the task.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tail
Follows the log as it is written rather than returning what has already been recorded.

```yaml
Type: SwitchParameter
Parameter Sets: Tail
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSec
How long to follow the log for before returning.

```yaml
Type: Int32
Parameter Sets: Tail
Aliases:

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

-Tail follows a running log and does not return until the task ends. Use the default set to
download the log as it stands.

The id of a task started by another command is on the object that command returns, for example
the taskId of an ldif import.

## RELATED LINKS

[Get-R1Task](Get-R1Task)

[Start-R1Task](Start-R1Task)
