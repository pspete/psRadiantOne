---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourceTable

## SYNOPSIS
Returns the tables of a database data source.

## SYNTAX

```
Get-R1DataSourceTable [-dataSourceName] <String> [[-catalog] <String>] [[-schemaPattern] <String>]
 [[-tableNamePattern] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the tables and views a database data source offers, optionally narrowed by catalog, schema or name.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourceTable -dataSourceName 'advworks'
```

Returns every table of the advworks data source.

### Example 2
```powershell
Get-R1DataSourceTable -dataSourceName 'advworks' -schemaPattern 'APP' -tableNamePattern 'CUST%'
```

Returns tables in the APP schema whose name starts with CUST.

## PARAMETERS

### -dataSourceName
The name of the data source.

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

### -catalog
The database catalog to list tables from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -schemaPattern
The database schema to list tables from.

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

### -tableNamePattern
A pattern limiting which table names are returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DatabaseTable

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSourceObject](Get-R1DataSourceObject)

[Get-R1DataSource](Get-R1DataSource)
