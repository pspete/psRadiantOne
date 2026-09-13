---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourceObject

## SYNOPSIS
Returns the objects available for schema extraction.

## SYNTAX

```
Get-R1DataSourceObject [-name] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the objects an LDAP or custom data source offers for schema extraction.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourceObject -name 'opendj'
```

Returns the objects available from the opendj data source.

## PARAMETERS

### -name
The name of the data source.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[Get-R1DataSourceTable](Get-R1DataSourceTable)
