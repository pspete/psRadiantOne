---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1SchemaFullObject

## SYNOPSIS
Updates a schema together with its tables, fields and relationships.

## SYNTAX

```
Set-R1SchemaFullObject [-schemaName] <String> [[-tablesWithFields] <Object[]>] [[-relationships] <Object[]>]
 [[-type] <String>] [[-dataSourceName] <String>] [[-baseDn] <String>] [[-publishToServer] <Boolean>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the complete schema in one request, including every table, the fields of each table, and
the relationships between them.

The current definition is retrieved before it is updated, and sent back with the supplied values
applied over it, so a property left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the definition as well
as to change it.

## EXAMPLES

### Example 1
```powershell
$Schema = Get-R1SchemaFullObject -schemaName 'default'
$Schema.tablesWithFields[0].fields[0].mappedAttrName = 'cn'
Set-R1SchemaFullObject -schemaName 'default' -tablesWithFields $Schema.tablesWithFields
```

Retrieves the complete schema, changes the attribute a field maps to, and sends the tables back.

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

### -tablesWithFields
The tables of the schema, each with its fields.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -relationships
The relationships between the tables of the schema.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Whether the schema is built from an LDAP source, a database source, or defined by hand.

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

### -dataSourceName
The name of the data source the schema reads from.

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

### -baseDn
The base DN the schema reads from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -publishToServer
Whether the schema is published to the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
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

Use this when several parts of a schema change together. To change one table or one relationship,
the dedicated commands are narrower and safer.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1SchemaFullObject](Get-R1SchemaFullObject)

[Set-R1Schema](Set-R1Schema)
