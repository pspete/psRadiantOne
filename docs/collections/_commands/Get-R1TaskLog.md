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
Get-R1TaskLog -id <String> -numberOfLines <Int32> [<CommonParameters>]
```

## DESCRIPTION
Returns the log a task has written. Given a number of lines, only the last of them are returned.

The whole log is returned when no number of lines is given.

## EXAMPLES

### Example 1
```powershell
Get-R1TaskLog -id 'e4ef6b3e'
```

Returns the log the task has written so far.

### Example 2
```powershell
Get-R1TaskLog -id 'e4ef6b3e' -numberOfLines 15
```

Returns the last fifteen lines of the log.

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

### -numberOfLines
The number of lines to return from the end of the log, between 1 and 2000.

```yaml
Type: Int32
Parameter Sets: Tail
Aliases:

Required: True
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

### System.String

## NOTES

Asking for a number of lines returns the last of them as the log stands, rather than following it.
The API takes a value between 1 and 2000, and every request carries one: asked without it the
endpoint follows the log and never closes the response.

The log is returned as one line per string. The API sends the tail as lines and the whole log as a
single string, so the whole log is split before it is returned.

The id of a task started by another command is on the object that command returns: an ldif
import returns the task itself, so its id is in the id property. The task object also carries its
log in a logs property, so Get-R1Task alone is often enough.

## RELATED LINKS

[Get-R1Task](Get-R1Task)

[Start-R1Task](Start-R1Task)
