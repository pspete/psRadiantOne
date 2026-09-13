---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSource

## SYNOPSIS
Returns the data sources in the catalog.

## SYNTAX

### All (Default)
```
Get-R1DataSource [-activeOnly <Boolean>] [-filter <String>] [-type <String>] [-sortBy <String>]
 [-sortOrder <String>] [-pageSize <Int32>] [<CommonParameters>]
```

### Name
```
Get-R1DataSource -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every data source, or a single one when it is named.

The list form follows the pagination of the API and returns every page.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSource
```

Returns every data source.

### Example 2
```powershell
Get-R1DataSource -name 'opendj'
```

Returns the opendj data source.

### Example 3
```powershell
Get-R1DataSource -activeOnly $true
```

Returns only the active data sources.

### Example 4
```powershell
Get-R1DataSource -filter 'ldap' -sortOrder 'DESC'
```

Returns data sources matching a filter, in descending order.

## PARAMETERS

### -name
The name of the data source.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -activeOnly
Returns only the active data sources.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
Returns only data sources whose name contains this string.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
The data source type, as listed by Get-R1DataSourceType.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sortBy
The property to sort the results by.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sortOrder
The direction to sort the results in.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
The number of entries requested per page.

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DataSource

## NOTES

The bind password is not returned: it reads back as an empty string when one is set.

## RELATED LINKS

[New-R1DataSource](New-R1DataSource)

[Set-R1DataSource](Set-R1DataSource)

[Remove-R1DataSource](Remove-R1DataSource)

[Test-R1DataSourceConnection](Test-R1DataSourceConnection)
