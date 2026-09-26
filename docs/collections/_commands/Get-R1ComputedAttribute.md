---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ComputedAttribute

## SYNOPSIS
Returns the computed attributes of a primary object.

## SYNTAX

```
Get-R1ComputedAttribute [-dn] <String> [-primaryObject] <String> [[-name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the computed attributes configured in the final output of a primary object in the object
builder, each with its expression, whether it is active, the priority of its computed value and the
origins of the attribute it is presented as.

The output carries the node and primary object it came from, so it can be piped to
Set-R1ComputedAttribute or Remove-R1ComputedAttribute.

This reads the object model. Whether a computed value appears in a directory search of the node is a
separate question, which depends on how the node is cached.

## EXAMPLES

### Example 1
```powershell
Get-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson'
```

Returns every computed attribute of the primary object.

### Example 2
```powershell
Get-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' -name 'displayName' | Format-List
```

Returns the displayName computed attribute with all of its properties.

### Example 3
```powershell
Get-R1ComputedAttribute -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson' |
    Where-Object { -not $_.active } | Remove-R1ComputedAttribute
```

Removes every computed attribute of the primary object which is not active.

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
The name of a single computed attribute to return. Every computed attribute is returned if it is
not specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.ComputedAttribute

## NOTES

## RELATED LINKS

[Add-R1ComputedAttribute](Add-R1ComputedAttribute)

[Set-R1ComputedAttribute](Set-R1ComputedAttribute)

[Remove-R1ComputedAttribute](Remove-R1ComputedAttribute)

[Get-R1SecondaryObject](Get-R1SecondaryObject)
