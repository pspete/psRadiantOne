---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1SchemaRelationship

## SYNOPSIS
Returns the relationships of a schema.

## SYNTAX

### All (Default)
```
Get-R1SchemaRelationship -schemaName <String> [<CommonParameters>]
```

### RelationshipId
```
Get-R1SchemaRelationship -schemaName <String> -relationshipId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every relationship defined in the schema, or a single relationship when one is named.

## EXAMPLES

### Example 1
```powershell
Get-R1SchemaRelationship -schemaName 'default'
```

Returns every relationship in the default schema.

### Example 2
```powershell
Get-R1SchemaRelationship -schemaName 'default' -relationshipId 'rel1'
```

Returns the rel1 relationship.

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

### -relationshipId
The identifier of the relationship.

```yaml
Type: String
Parameter Sets: RelationshipId
Aliases: id

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

### psRadiantOne.Relationship

## NOTES

## RELATED LINKS

[New-R1SchemaRelationship](New-R1SchemaRelationship)

[Set-R1SchemaRelationship](Set-R1SchemaRelationship)

[Remove-R1SchemaRelationship](Remove-R1SchemaRelationship)

[Get-R1SchemaRelationshipTree](Get-R1SchemaRelationshipTree)
