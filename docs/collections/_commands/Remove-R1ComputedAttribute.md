---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1ComputedAttribute

## SYNOPSIS
Removes a computed attribute from a primary object.

## SYNTAX

```
Remove-R1ComputedAttribute [-dn] <String> [-primaryObject] <String> [-name] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a computed attribute from the final output of a primary object in the object builder, which
is what the DELETE button of the computed attributes tab does.

The expression is removed, and so is the computed origin of the attribute it was presented as. Where
the attribute has other origins it survives with those; where computed was its only origin it is
removed from the final output altogether.

## EXAMPLES

### Example 1
```powershell
Remove-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'displayName'
```

Removes the displayName computed attribute.

### Example 2
```powershell
Get-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' |
    Remove-R1ComputedAttribute -Confirm:$false
```

Removes every computed attribute of the primary object without prompting for each.

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
The name of the computed attribute to remove.

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

An attribute whose only origin was computed is removed from the final output, so any setting it
carried there, such as being hidden, is removed with it.

## RELATED LINKS

[Get-R1ComputedAttribute](Get-R1ComputedAttribute)

[Add-R1ComputedAttribute](Add-R1ComputedAttribute)

[Set-R1ComputedAttribute](Set-R1ComputedAttribute)
