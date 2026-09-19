---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AccessControlSetting

## SYNOPSIS
Returns the access control settings.

## SYNTAX

```
Get-R1AccessControlSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the authorization settings held in access control settings, covering whether access
control instructions are enforced, how anonymous and nested group access is treated, and whether
access control applies to the root DSE.

## EXAMPLES

### Example 1
```powershell
Get-R1AccessControlSetting
```

Returns the access control settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.AccessControlSetting

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
