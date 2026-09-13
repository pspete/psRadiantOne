---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1JdbcDriverFile

## SYNOPSIS
Returns the uploaded JDBC driver files.

## SYNTAX

```
Get-R1JdbcDriverFile [<CommonParameters>]
```

## DESCRIPTION
Returns every uploaded JDBC driver file, with the driver classes each contains.

## EXAMPLES

### Example 1
```powershell
Get-R1JdbcDriverFile
```

Returns every driver file and its classes.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DriverFileClassName

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Import-R1JdbcDriver](Import-R1JdbcDriver)

[Remove-R1JdbcDriver](Remove-R1JdbcDriver)
