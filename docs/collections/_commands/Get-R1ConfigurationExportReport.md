---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ConfigurationExportReport

## SYNOPSIS
Returns the configuration export reports.

## SYNTAX

### All (Default)
```
Get-R1ConfigurationExportReport [<CommonParameters>]
```

### Timestamp
```
Get-R1ConfigurationExportReport -timestamp <DateTime> [<CommonParameters>]
```

## DESCRIPTION
Returns the reports of past configuration exports, or one report when a time is given.

## EXAMPLES

### Example 1
```powershell
Get-R1ConfigurationExportReport
```

Returns the export reports.

### Example 2
```powershell
Get-R1ConfigurationExportReport -timestamp '2026-01-30T08:30:00Z'
```

Returns one export report.

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

### psRadiantOne.ConfigurationExportReport

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Export-R1Configuration](Export-R1Configuration)
