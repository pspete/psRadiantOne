---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ComputedAttributeFunction

## SYNOPSIS
Returns the functions available to a computed attribute.

## SYNTAX

```
Get-R1ComputedAttributeFunction [-dn] <String> [-primaryObject] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the functions which can be used in the expression of a computed attribute of a primary object, each with its signature, parameters, description and an example. A function can appear more than once with different parameters; its signature is what distinguishes them.

## EXAMPLES

### Example 1
```powershell
Get-R1ComputedAttributeFunction -dn 'o=companyprofiles' -primaryObject 'inetOrgPerson'
```

Returns the functions available to a computed attribute at o=companyprofiles.

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

### psRadiantOne.ComputedAttributeFunction

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
