---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Invoke-R1SchemaDiff

## SYNOPSIS
Applies schema changes found by a comparison.

## SYNTAX

```
Invoke-R1SchemaDiff [-applyType] <String> [-oldSchemaName] <String> [[-newSchemaName] <String>]
 [-isLdap] <Boolean> [-datasource] <String> [-objects] <String[]> [-changes] <Object[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Applies the changes found by Compare-R1Schema, either updating the existing schema or saving the
result as a new one.

## EXAMPLES

### Example 1
```powershell
Invoke-R1SchemaDiff -applyType 'UPDATE' -oldSchemaName 'default' -isLdap $false -datasource 'advworks' -objects 'APP.CUSTOMERS' -changes $Changes
```

Applies the changes to the existing schema.

### Example 2
```powershell
Invoke-R1SchemaDiff -applyType 'SAVE_AS_NEW' -oldSchemaName 'default' -newSchemaName 'default_v2' -isLdap $false -datasource 'advworks' -objects 'APP.CUSTOMERS' -changes $Changes
```

Saves the result as a new schema, leaving the original alone.

## PARAMETERS

### -applyType
Whether the changes are saved as a new schema or applied to the existing one.

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

### -oldSchemaName
The schema the changes apply to.

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

### -newSchemaName
The name for the new schema, when saving as new.

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

### -isLdap
Whether the data source is an LDAP one.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -datasource
The name of the data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases: dataSourceName

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objects
The tables or objects in scope.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -changes
The changes to apply, as returned by Compare-R1Schema.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
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

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[Compare-R1Schema](Compare-R1Schema)

[Get-R1Schema](Get-R1Schema)
