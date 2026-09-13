---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1MigrationExport

## SYNOPSIS
Returns the migration exported data.

## SYNTAX

```
Get-R1MigrationExport [<CommonParameters>]
```

## DESCRIPTION
Returns the exported data of the current migration operation.

## EXAMPLES

### Example 1
```powershell
Get-R1MigrationExport
```

Returns the migration exported data.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.MigrationData

## NOTES

The migration endpoints report an error rather than an empty result when no operation is
active. Get-R1MigrationStatus is the one to call first: it answers whether anything is
running.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Export-R1MigrationData](Export-R1MigrationData)

[Get-R1MigrationStatus](Get-R1MigrationStatus)
