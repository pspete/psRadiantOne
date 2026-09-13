---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1SchemaRelationship

## SYNOPSIS
Updates a relationship of a schema.

## SYNTAX

```
Set-R1SchemaRelationship [-schemaName] <String> [-relationshipId] <String> [[-source] <String>]
 [[-sourceAttrs] <String[]>] [[-dest] <String>] [[-destAttrs] <String[]>] [[-tags] <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the named relationship.

The current definition is retrieved before it is updated, and sent back with the supplied values
applied over it, so a property left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the definition as well
as to change it.

## EXAMPLES

### Example 1
```powershell
Set-R1SchemaRelationship -schemaName 'default' -relationshipId 'rel1' -destAttrs 'CUSTOMERID', 'REGIONID'
```

Changes the attributes the relationship joins on, leaving the rest as they are.

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

### -relationshipId
The identifier of the relationship.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 2
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

Required: False
Position: 3
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

Required: False
Position: 4
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

Required: False
Position: 5
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

### System.Void

## NOTES

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1SchemaRelationship](Get-R1SchemaRelationship)
