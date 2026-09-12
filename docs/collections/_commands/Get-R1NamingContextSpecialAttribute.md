---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextSpecialAttribute

## SYNOPSIS
Returns the special attribute settings of a naming context.

## SYNTAX

```
Get-R1NamingContextSpecialAttribute [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the special attribute settings configured on the naming context node, being its linked
attributes, dynamic group settings, unnested groups, referential integrity rules and attribute
uniqueness rules.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextSpecialAttribute -dn 'o=vds'
```

Returns the special attribute settings of o=vds.

### Example 2
```powershell
(Get-R1NamingContextSpecialAttribute -dn 'o=vds').linkedAttributes
```

Returns just the linked attribute mappings configured on o=vds.

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

### psRadiantOne.SpecialAttributes

## NOTES

## RELATED LINKS

[Set-R1NamingContextSpecialAttribute](Set-R1NamingContextSpecialAttribute)

[Get-R1GlobalSpecialAttribute](Get-R1GlobalSpecialAttribute)
