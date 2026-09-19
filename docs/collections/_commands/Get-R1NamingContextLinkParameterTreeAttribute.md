---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLinkParameterTreeAttribute

## SYNOPSIS
Returns the attributes available to a link parameter.

## SYNTAX

```
Get-R1NamingContextLinkParameterTreeAttribute [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the attributes of the naming context node which can be used as a link parameter, each with its type.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLinkParameterTreeAttribute -dn 'EMPLOYEES,o=DBJoin'
```

Returns the attributes available to a link parameter at EMPLOYEES,o=DBJoin.

## PARAMETERS

### -dn
The DN of the naming context node.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.LinkParameterTreeAttribute

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
