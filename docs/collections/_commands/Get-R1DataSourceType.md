---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourceType

## SYNOPSIS
Returns the data source types.

## SYNTAX

### All (Default)
```
Get-R1DataSourceType [<CommonParameters>]
```

### Name
```
Get-R1DataSourceType -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every data source type the deployment offers, or a single type when it is named. These are
the templates a data source is created from.

Data source types do not all carry the same properties. An LDAP type has isLdap, a database
type has driverClass and urlPattern, and a custom type has javaClassName, pluginName and a
writable meta collection. Which properties a type has is decided by its backend category.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourceType
```

Returns every data source type.

### Example 2
```powershell
Get-R1DataSourceType -name 'Active Directory'
```

Returns the Active Directory type.

### Example 3
```powershell
Get-R1DataSourceType | Where-Object { -not $PSItem.readOnly }
```

Returns only the types which can be modified.

## PARAMETERS

### -name
The name of the data source type.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DataSourceType

## NOTES

Built-in types report readOnly true and cannot be changed.

## RELATED LINKS

[New-R1DataSourceType](New-R1DataSourceType)

[Set-R1DataSourceType](Set-R1DataSourceType)

[Remove-R1DataSourceType](Remove-R1DataSourceType)

[New-R1DataSource](New-R1DataSource)
