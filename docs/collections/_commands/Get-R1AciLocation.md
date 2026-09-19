---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AciLocation

## SYNOPSIS
Returns the DNs which hold access control instructions.

## SYNTAX

```
Get-R1AciLocation [<CommonParameters>]
```

## DESCRIPTION
Returns the base DNs at which access control instructions are defined. These are the values to
pass as the baseDn of the other ACI commands.

## EXAMPLES

### Example 1
```powershell
Get-R1AciLocation
```

Returns every DN holding access control instructions.

### Example 2
```powershell
Get-R1AciLocation | ForEach-Object { Get-R1Aci -baseDn $PSItem }
```

Returns the ACIs held at every location.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
