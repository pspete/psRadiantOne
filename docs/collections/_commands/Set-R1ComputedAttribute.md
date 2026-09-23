---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1ComputedAttribute

## SYNOPSIS
Changes a computed attribute of a primary object.

## SYNTAX

```
Set-R1ComputedAttribute [-dn] <String> [-primaryObject] <String> [-name] <String> [[-expression] <String>]
 [[-active] <Boolean>] [[-priority] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the expression, the active state or the priority of a computed attribute already configured
on a primary object. At least one of the three must be specified, and everything else about the
object model is sent back unchanged.

The priority is saved in a request of its own. The server discards the computed attribute if a
priority change shares a request with a change to the expression or the active state, so specifying
both means two requests, the expression first.

Use Add-R1ComputedAttribute to create a computed attribute; this command changes one which exists.

## EXAMPLES

### Example 1
```powershell
Set-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'displayName' -expression 'sn+", "+givenName'
```

Changes the expression of the displayName computed attribute.

### Example 2
```powershell
Set-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'sn' -priority 'LOWEST'
```

Gives the other origins of the sn attribute precedence over the computed value.

### Example 3
```powershell
Get-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'displayName' |
    Set-R1ComputedAttribute -active $false
```

Deactivates the displayName computed attribute, piping it in rather than naming the node again.

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
The name of the computed attribute to change.

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

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -active
Whether the computed attribute is active.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
Default value: None
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

Specifying a priority alongside an expression or an active state means two requests, so the first
can have been saved when the second fails.

## RELATED LINKS

[Get-R1ComputedAttribute](Get-R1ComputedAttribute)

[Add-R1ComputedAttribute](Add-R1ComputedAttribute)

[Remove-R1ComputedAttribute](Remove-R1ComputedAttribute)

[New-R1ComputedAttributeExpression](New-R1ComputedAttributeExpression)
