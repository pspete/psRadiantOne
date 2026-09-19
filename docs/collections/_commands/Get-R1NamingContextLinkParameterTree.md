---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLinkParameterTree

## SYNOPSIS
Returns the tree of nodes available to a link parameter.

## SYNTAX

```
Get-R1NamingContextLinkParameterTree [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the naming context node at the DN with the nodes beneath it, each labelled with its path and whether it is a label or a content node, from which the attributes of a link parameter are chosen.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLinkParameterTree -dn 'o=AggregateView'
```

Returns the tree of nodes available to a link parameter at o=AggregateView.

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

### psRadiantOne.LinkParameterTree

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
