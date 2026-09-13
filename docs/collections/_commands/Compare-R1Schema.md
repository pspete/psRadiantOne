---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Compare-R1Schema

## SYNOPSIS
Compares a schema against its data source.

## SYNTAX

```
Compare-R1Schema [-name] <String> [-dataSourceName] <String> [-ldap] <Boolean> [-objects] <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Compares a schema against the current state of its data source and returns the differences found.
Nothing is changed. Pass the changes to Invoke-R1SchemaDiff to apply them.

## EXAMPLES

### Example 1
```powershell
Compare-R1Schema -name 'default' -dataSourceName 'advworks' -ldap $false -objects 'APP.CUSTOMERS'
```

Compares one table of a schema against the database.

## PARAMETERS

### -name
The name of the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: schemaName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSourceName
The name of the data source to compare against.

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

### -ldap
Whether the data source is an LDAP one.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: False
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
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.SchemaDiffTree

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Invoke-R1SchemaDiff](Invoke-R1SchemaDiff)

[Get-R1Schema](Get-R1Schema)
