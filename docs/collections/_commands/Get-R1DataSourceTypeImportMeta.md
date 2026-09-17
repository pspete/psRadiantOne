---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourceTypeImportMeta

## SYNOPSIS
Returns the templates in an upload session.

## SYNTAX

### All (Default)
```
Get-R1DataSourceTypeImportMeta -importId <String> [<CommonParameters>]
```

### Name
```
Get-R1DataSourceTypeImportMeta -importId <String> -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every template held in an upload session, or a single one when it is named.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourceTypeImportMeta -importId 'imp1'
```

Returns every template in the session.

### Example 2
```powershell
Get-R1DataSourceTypeImportMeta -importId 'imp1' -name 'My Custom'
```

Returns one template.

## PARAMETERS

### -importId
The identifier of the upload session, as returned by Import-R1DataSourceType.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

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

## RELATED LINKS

[New-R1DataSourceTypeImportMeta](New-R1DataSourceTypeImportMeta)

[Set-R1DataSourceTypeImportMeta](Set-R1DataSourceTypeImportMeta)

[Remove-R1DataSourceTypeImportMeta](Remove-R1DataSourceTypeImportMeta)
