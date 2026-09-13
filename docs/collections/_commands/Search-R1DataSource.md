---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Search-R1DataSource

## SYNOPSIS
Searches data sources and their objects.

## SYNTAX

```
Search-R1DataSource [[-dataSourceFilter] <String>] [[-objectFilter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches for data sources by name, and for objects within them. Both filters are optional, but no
objects are searched unless an object filter is given.

## EXAMPLES

### Example 1
```powershell
Search-R1DataSource -objectFilter 'person'
```

Searches every data source for objects matching person.

### Example 2
```powershell
Search-R1DataSource -dataSourceFilter 'open' -objectFilter 'group'
```

Searches only data sources whose name contains open.

## PARAMETERS

### -dataSourceFilter
Searches only data sources whose name contains this string. Every data source is searched when it is not given.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectFilter
Searches for objects whose name contains this string. No objects are searched when it is not given.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DataSourceSearchResult

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[Get-R1DataSourceObject](Get-R1DataSourceObject)
