---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1Operation

## SYNOPSIS
Starts an entry statistics refresh.

## SYNTAX

```
New-R1Operation [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a refresh of the entry statistics and returns the operation, whose name is used to track
its progress with Get-R1Operation, and to stop or resume it.

## EXAMPLES

### Example 1
```powershell
New-R1Operation
```

Starts a refresh.

### Example 2
```powershell
$op = New-R1Operation
Get-R1Operation -name $op.name
```

Starts a refresh and checks its status.

## PARAMETERS

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.RefreshOperation

## NOTES

The refresh can finish before the call returns: against a small directory the operation comes
back already in state DONE, with the counts in its result. Nothing is left to stop or resume in
that case.

## RELATED LINKS
