---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLabelProperty

## SYNOPSIS
Returns the properties of a label node.

## SYNTAX

```
Get-R1NamingContextLabelProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of a label node: the prefix and value of its RDN, its object classes, its description and its virtual attributes.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLabelProperty -dn 'ou=MyProfile,dv=globalprofiles'
```

Returns the properties of a label node at ou=MyProfile,dv=globalprofiles.

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

### psRadiantOne.LabelProperties

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
