---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLinkProperty

## SYNOPSIS
Returns the properties of a link node.

## SYNTAX

```
Get-R1NamingContextLinkProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of a standard or merge link node: the view it links to, the link type, its object classes, the data source, base DN and schema behind it, its link parameters and its virtual attributes.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLinkProperty -dn 'dv=address book,o=vds'
```

Returns the properties of a link node at dv=address book,o=vds.

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

### psRadiantOne.LinkProperties

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
