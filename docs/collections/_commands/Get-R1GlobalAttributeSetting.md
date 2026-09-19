---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1GlobalAttributeSetting

## SYNOPSIS
Returns the global attribute handling settings.

## SYNTAX

```
Get-R1GlobalAttributeSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the settings governing how specific attributes are handled globally, including which are
treated as binary or multi valued and which are excluded from results, logs or keyword search.

## EXAMPLES

### Example 1
```powershell
Get-R1GlobalAttributeSetting
```

Returns the global attribute handling settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.GlobalAttributes

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
