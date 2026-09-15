---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1MigrationStatus

## SYNOPSIS
Returns the status of the migration operation.

## SYNTAX

```
Get-R1MigrationStatus [<CommonParameters>]
```

## DESCRIPTION
Returns the status of the current migration operation. Unlike the other migration readers, this
answers even when nothing is running.

## EXAMPLES

### Example 1
```powershell
Get-R1MigrationStatus
```

Returns the migration status.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.OperationStatus

## NOTES

## RELATED LINKS

[New-R1MigrationPlan](New-R1MigrationPlan)

[Stop-R1Migration](Stop-R1Migration)

[Clear-R1Migration](Clear-R1Migration)
