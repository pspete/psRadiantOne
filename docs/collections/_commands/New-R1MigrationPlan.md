---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1MigrationPlan

## SYNOPSIS
Starts generating a migration plan.

## SYNTAX

```
New-R1MigrationPlan [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts generating a migration plan and returns the status of the operation it began.

## EXAMPLES

### Example 1
```powershell
New-R1MigrationPlan
```

Starts generating a migration plan.

### Example 2
```powershell
New-R1MigrationPlan
Get-R1MigrationStatus
```

Starts the operation and checks on it.

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

### psRadiantOne.OperationStatus

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1MigrationPlan](Get-R1MigrationPlan)

[Get-R1MigrationStatus](Get-R1MigrationStatus)
