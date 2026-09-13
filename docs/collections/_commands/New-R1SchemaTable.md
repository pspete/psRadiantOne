---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1SchemaTable

## SYNOPSIS
Adds a table or view to a schema.

## SYNTAX

```
New-R1SchemaTable [-schemaName] <String> [-name] <String> [-objectClass] <String> [[-baseTable] <String>]
 [[-candidateKeyName] <String>] [[-candidateKeys] <String[]>] [[-owner] <String>] [[-primaryKeys] <String[]>]
 [[-isTable] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a table or view to the schema. The object as created is returned.

## EXAMPLES

### Example 1
```powershell
New-R1SchemaTable -schemaName 'default' -name 'APP.CUSTOMERS' -objectClass 'vdAPPCUSTOMERS' -primaryKeys 'CUSTOMERID'
```

Adds the APP.CUSTOMERS table with a primary key.

### Example 2
```powershell
New-R1SchemaTable -schemaName 'default' -name 'APP.ACTIVE' -objectClass 'vdAPPACTIVE' -baseTable 'APP.CUSTOMERS' -isTable $false
```

Adds a view built over the customers table.

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

### -name
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

### -objectClass
The object class entries built from this table are given.

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

### -baseTable
The underlying table this view is built from.

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

### -candidateKeyName
The candidate key used to identify a row.

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

### -candidateKeys
The columns which could serve as the candidate key.

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

### -owner
The owner of the table in the source system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -primaryKeys
The columns forming the primary key.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isTable
Whether the object is a table. Set false for a view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

### psRadiantOne.Table

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1SchemaTable](Get-R1SchemaTable)

[Add-R1SchemaTable](Add-R1SchemaTable)

[Set-R1SchemaTable](Set-R1SchemaTable)
