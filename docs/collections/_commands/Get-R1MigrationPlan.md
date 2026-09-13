---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1MigrationPlan

## SYNOPSIS
Returns the migration plan.

## SYNTAX

```
Get-R1MigrationPlan [<CommonParameters>]
```

## DESCRIPTION
Returns the plan of the current migration operation.

## EXAMPLES

### Example 1
```powershell
Get-R1MigrationPlan
```

Returns the migration plan.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.MigrationPlan

## NOTES

The migration endpoints report an error rather than an empty result when no operation is
active. Get-R1MigrationStatus is the one to call first: it answers whether anything is
running.

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[New-R1MigrationPlan](New-R1MigrationPlan)

[Get-R1MigrationStatus](Get-R1MigrationStatus)
