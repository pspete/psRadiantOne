---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ConfigurationImportReport

## SYNOPSIS
Returns the configuration import reports.

## SYNTAX

### All (Default)
```
Get-R1ConfigurationImportReport [<CommonParameters>]
```

### Timestamp
```
Get-R1ConfigurationImportReport -timestamp <DateTime> [<CommonParameters>]
```

## DESCRIPTION
Returns the reports of past configuration imports, or one report when a time is given.

## EXAMPLES

### Example 1
```powershell
Get-R1ConfigurationImportReport
```

Returns the import reports.

### Example 2
```powershell
Get-R1ConfigurationImportReport -timestamp '2026-01-30T08:30:00Z'
```

Returns one import report.

## PARAMETERS

### -timestamp
The time of the report, as returned in the report list.

```yaml
Type: DateTime
Parameter Sets: Timestamp
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

### psRadiantOne.ConfigurationImportReport

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Import-R1Configuration](Import-R1Configuration)
