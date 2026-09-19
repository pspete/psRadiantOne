---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ServiceSummary

## SYNOPSIS
Returns a summary of the configured services.

## SYNTAX

```
Get-R1ServiceSummary [<CommonParameters>]
```

## DESCRIPTION
Returns the counts shown on the dashboard: data sources by type, naming contexts by state, and
caches by refresh mode.

## EXAMPLES

### Example 1
```powershell
Get-R1ServiceSummary
```

Returns the service summary.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ServiceSummary

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
