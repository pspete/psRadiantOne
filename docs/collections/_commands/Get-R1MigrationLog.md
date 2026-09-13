---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1MigrationLog

## SYNOPSIS
Returns the migration log.

## SYNTAX

```
Get-R1MigrationLog [<CommonParameters>]
```

## DESCRIPTION
Returns the log of the current migration operation.

## EXAMPLES

### Example 1
```powershell
Get-R1MigrationLog
```

Returns the migration log.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.MigrationLog

## NOTES

The migration endpoints report an error rather than an empty result when no operation is
active. Get-R1MigrationStatus is the one to call first: it answers whether anything is
running.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1MigrationStatus](Get-R1MigrationStatus)
