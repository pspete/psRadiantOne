---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Add-R1ComputedAttribute

## SYNOPSIS
Adds a computed attribute to a primary object.

## SYNTAX

```
Add-R1ComputedAttribute [-dn] <String> [-primaryObject] <String> [-name] <String> [-expression] <String>
 [[-priority] <String>] [[-active] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a computed attribute to the final output of a primary object in the object builder, which is
what the ADD button of the computed attributes tab does.

A computed attribute is two coupled changes to the object model: the expression itself, and the
attribute it is presented as. Where the attribute already exists, it gains a computed origin
alongside the origins it has; where it does not, it is created with computed as its only origin.
Both changes are made here.

A priority other than NORMAL is saved in a second request. The server discards the computed
attribute if a priority is sent in the same request which creates it.

The model is retrieved first and sent back changed, so a computed attribute can only be added to a
primary object which exists.

## EXAMPLES

### Example 1
```powershell
Add-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'displayName' -expression 'givenName+" "+sn'
```

Adds a displayName computed attribute which joins the given name and surname.

### Example 2
```powershell
$Expression = New-R1ComputedAttributeExpression -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -signature 'upper(attribute)' -value 'sn'
Add-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'sn' -expression $Expression -priority 'HIGHEST'
```

Adds a computed attribute over the existing sn attribute and gives the computed value precedence,
building the expression from one of the functions the node offers.

### Example 3
```powershell
Add-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'employeeType' -expression '"contractor"' -active $false
```

Adds a computed attribute without activating it.

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the computed attribute. This is the attribute name the computed value is presented as,
whether or not an attribute of that name already exists.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expression
The expression the value is computed from. Pass it as it would be typed into the expression editor,
or build it from a function with New-R1ComputedAttributeExpression.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
The priority of the computed value, which decides whether it wins over the other origins of the
attribute. A computed origin beats an origin of lower priority and loses to one of higher priority.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: LOWEST, LOW, NORMAL, HIGH, HIGHEST

Required: False
Position: 5
Default value: NORMAL
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -active
Whether the computed attribute is active. Defaults to true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Void

## NOTES

A priority other than NORMAL is saved in a second request, so the computed attribute exists at
NORMAL priority in between the two.

## RELATED LINKS

[Get-R1ComputedAttribute](Get-R1ComputedAttribute)

[Set-R1ComputedAttribute](Set-R1ComputedAttribute)

[Remove-R1ComputedAttribute](Remove-R1ComputedAttribute)

[New-R1ComputedAttributeExpression](New-R1ComputedAttributeExpression)
