---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1GlobalDynamicGroup

## SYNOPSIS
Returns the dynamic groups defined across the namespace.

## SYNTAX

```
Get-R1GlobalDynamicGroup [<CommonParameters>]
```

## DESCRIPTION
Returns every dynamic group defined across the namespace, each identified by its LDAP URL and
indicating whether its membership is cached.

## EXAMPLES

### Example 1
```powershell
Get-R1GlobalDynamicGroup
```

Returns all dynamic groups defined across the namespace.

### Example 2
```powershell
Get-R1GlobalDynamicGroup | Where-Object cache
```

Returns only those dynamic groups whose membership is cached.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DynamicGroup

## NOTES
A deployment with no dynamic groups defined returns nothing.

## RELATED LINKS
