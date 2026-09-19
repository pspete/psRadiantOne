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

Searches every data source for objects whose name contains person, ignoring case.

### Example 2
```powershell
Search-R1DataSource -dataSourceFilter 'open' -objectFilter 'group'
```

Searches the data sources whose name contains open for objects whose name contains group.

### Example 3
```powershell
Search-R1DataSource -dataSourceFilter 'open'
```

Returns the data sources whose name contains open. No objects are searched, so each comes back
with an empty list of objects.

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

Both parameters are optional, but at least one must be given: with neither, the API answers
"At least one of dataSourceFilter and objectFilter must be provided". An empty string counts as
not given.

Each filter matches the names which contain it, case-insensitively. Neither is a wildcard: an
asterisk matches only a name which holds an asterisk. No filter returns everything, so use
Get-R1DataSource for the full list of data sources.

Without -objectFilter no objects are searched and each data source comes back with an empty
objects collection. Without -dataSourceFilter every data source is searched.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[Get-R1DataSourceObject](Get-R1DataSourceObject)
