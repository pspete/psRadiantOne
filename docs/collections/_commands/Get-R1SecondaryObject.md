---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SecondaryObject

## SYNOPSIS
Returns the object model built around a primary object.

## SYNTAX

```
Get-R1SecondaryObject [-dn] <String> [-primaryObject] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the object model the object builder holds for a primary object of a proxy, content or container node: its input sources and their related objects, its attribute mappings, its joins to secondary objects, its join computed attributes, and the final output with its attribute precedence, bind order and computed attributes.

## EXAMPLES

### Example 1
```powershell
Get-R1SecondaryObject -dn 'o=companyprofiles' -primaryObject 'inetOrgPerson'
```

Returns the object model built around a primary object at o=companyprofiles.

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

### -primaryObject
The name of the primary object.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.SecondaryObject

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
