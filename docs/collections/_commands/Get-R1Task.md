---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Task

## SYNOPSIS
Returns the scheduled tasks.

## SYNTAX

### All (Default)
```
Get-R1Task [<CommonParameters>]
```

### Id
```
Get-R1Task -id <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every task the scheduler knows about, or a single task when one is named.

## EXAMPLES

### Example 1
```powershell
Get-R1Task
```

Returns every task.

### Example 2
```powershell
Get-R1Task -id 'e4ef6b3e'
```

Returns one task.

### Example 3
```powershell
Get-R1Task | Where-Object status -eq 'RUNNING'
```

Returns the tasks currently running.

## PARAMETERS

### -id
The identifier of the task.

```yaml
Type: String
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Task

## NOTES

## RELATED LINKS

[Set-R1Task](Set-R1Task)

[Start-R1Task](Start-R1Task)

[Stop-R1Task](Stop-R1Task)

[Get-R1TaskLog](Get-R1TaskLog)
