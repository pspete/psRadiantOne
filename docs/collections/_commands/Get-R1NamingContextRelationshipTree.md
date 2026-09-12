---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextRelationshipTree

## SYNOPSIS
Returns the relationship tree of a naming context.

## SYNTAX

### Root (Default)
```
Get-R1NamingContextRelationshipTree -dn <String> [<CommonParameters>]
```

### Node
```
Get-R1NamingContextRelationshipTree -dn <String> -relationshipDn <String> [-isRelatedObjectsOnly <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the root of the relationship tree beneath the naming context node together with its
children, or a single node within that tree when a relationship DN is given.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextRelationshipTree -dn 'o=vds'
```

Returns the root relationship node of o=vds and its children.

### Example 2
```powershell
Get-R1NamingContextRelationshipTree -dn 'o=vds' -relationshipDn 'dv=orders'
```

Returns the dv=orders node within the relationship tree of o=vds.

### Example 3
```powershell
Get-R1NamingContextRelationshipTree -dn 'o=vds' -relationshipDn 'dv=orders' -isRelatedObjectsOnly $false
```

Returns the dv=orders node, including objects which are not related.

## PARAMETERS

### -dn
The DN of the naming context node.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -relationshipDn
The DN of the relationship node within the tree. Without it, the root node and its children are returned.

```yaml
Type: String
Parameter Sets: Node
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isRelatedObjectsOnly
Returns only related objects.

```yaml
Type: Boolean
Parameter Sets: Node
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.RelationshipNode

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)

[Get-R1NamingContextChild](Get-R1NamingContextChild)
