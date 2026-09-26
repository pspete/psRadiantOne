---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1SchemaTableField

## SYNOPSIS
Replaces the fields of a table.

## SYNTAX

```
Set-R1SchemaTableField [-schemaName] <String> [-tableName] <String> [-fields] <Object[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the fields of the named table with the collection supplied. The request body is the
complete set of fields.

## EXAMPLES

### Example 1
```powershell
$Fields = Get-R1SchemaTableField -schemaName 'default' -tableName 'APP.CUSTOMERS'
$Fields[0].mappedAttrName = 'cn'
Set-R1SchemaTableField -schemaName 'default' -tableName 'APP.CUSTOMERS' -fields $Fields
```

Retrieves the fields, changes the attribute one maps to, and sends them all back.

## PARAMETERS

### -schemaName
The name of the schema.

```yaml
Type: String
Parameter Sets: (All)
Aliases: schema

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tableName
The name of the table or view.

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

### -fields
The complete collection of fields for the table.

```yaml
Type: Object[]
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

### None

## OUTPUTS

### System.Void

## NOTES

The fields supplied replace those configured, so a field left out is removed. Retrieve the
current collection with Get-R1SchemaTableField and pass back the whole of it.

## RELATED LINKS

[Get-R1SchemaTableField](Get-R1SchemaTableField)
