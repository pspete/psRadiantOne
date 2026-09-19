---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheRealTimeConnectorType

## SYNOPSIS
Returns the types available to a real time connector of a cache.

## SYNTAX

```
Get-R1CacheRealTimeConnectorType [-dn] <String> [-connectorId] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the types a real time connector of the persistent cache at the DN can be configured as, each with the properties it takes, their defaults and whether they can be edited.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheRealTimeConnectorType -dn 'o=hrdatabase' -connectorId 'northwind_APP.EMPLOYEES'
```

Returns the types available to a real time connector of a cache at o=hrdatabase.

## PARAMETERS

### -dn
The DN of the cache.

```yaml
Type: String
Parameter Sets: (All)
Aliases: label

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -connectorId
The id of the connector, as returned by Get-R1CacheRealTimeConnector.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.CacheRealTimeConnectorType

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
