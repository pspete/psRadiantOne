---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1SchemaRelationship

## SYNOPSIS
Creates a relationship between two tables of a schema.

## SYNTAX

```
New-R1SchemaRelationship [-schemaName] <String> [-source] <String> [-sourceAttrs] <String[]> [-dest] <String>
 [-destAttrs] <String[]> [[-id] <String>] [[-tags] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a relationship joining a source table to a destination table on the attributes given.
The relationship as created is returned.

## EXAMPLES

### Example 1
```powershell
New-R1SchemaRelationship -schemaName 'default' -source 'APP.CUSTOMERS' -sourceAttrs 'CUSTOMERID' -dest 'APP.ORDERS' -destAttrs 'CUSTOMERID'
```

Joins customers to orders on the customer identifier.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -source
The table the relationship starts from.

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

### -sourceAttrs
The attributes of the source table the relationship joins on.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dest
The table the relationship points at.

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

### -destAttrs
The attributes of the destination table the relationship joins on.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The identifier of the relationship. One is assigned when not supplied.

```yaml
Type: String
Parameter Sets: (All)
Aliases: relationshipId

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
Tags to record against the relationship.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

### None

## OUTPUTS

### psRadiantOne.Relationship

## NOTES

The create returns nothing, so the new relationship's identifier has to be read back from the
schema before Set-R1SchemaRelationship or Remove-R1SchemaRelationship can act on it.

## RELATED LINKS

[Get-R1SchemaRelationship](Get-R1SchemaRelationship)

[New-R1RecursiveSchemaRelationship](New-R1RecursiveSchemaRelationship)
