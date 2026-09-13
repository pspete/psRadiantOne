---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaRelationshipTree

## SYNOPSIS
Returns the relationship tree of a schema.

## SYNTAX

### Root (Default)
```
Get-R1SchemaRelationshipTree -schemaName <String> [<CommonParameters>]
```

### Node
```
Get-R1SchemaRelationshipTree -schemaName <String> -relationshipDn <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the root of the relationship tree of the schema together with its children, or a single
node within that tree when a relationship DN is given.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaRelationshipTree -schemaName 'default'
```

Returns the root of the relationship tree.

### Example 2
```powershell
Get-R1SchemaRelationshipTree -schemaName 'default' -relationshipDn 'dv=orders'
```

Returns the dv=orders node within the tree.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -relationshipDn
The DN of a node within the relationship tree. Without it, the root and its children are returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.RelationshipNode

## NOTES

## RELATED LINKS

[Get-R1SchemaRelationship](Get-R1SchemaRelationship)
