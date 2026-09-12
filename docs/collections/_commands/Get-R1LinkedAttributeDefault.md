---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LinkedAttributeDefault

## SYNOPSIS
Returns the default linked attribute definitions.

## SYNTAX

```
Get-R1LinkedAttributeDefault [<CommonParameters>]
```

## DESCRIPTION
Returns the linked attribute definitions the server provides by default, each pairing a backlink
attribute with the forward link attributes that populate it.

## EXAMPLES

### Example 1
```powershell
Get-R1LinkedAttributeDefault
```

Returns every default linked attribute definition.

### Example 2
```powershell
Get-R1LinkedAttributeDefault | Where-Object backlinkAttr -eq 'memberOf'
```

Returns the default definition for the memberOf backlink.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.LinkedAttributeDefault

## NOTES

## RELATED LINKS

[Get-R1GlobalSpecialAttribute](Get-R1GlobalSpecialAttribute)
