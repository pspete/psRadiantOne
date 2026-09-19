---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheRealTimeConnectorConfig

## SYNOPSIS
Returns the configuration of a real time connector of a cache.

## SYNTAX

```
Get-R1CacheRealTimeConnectorConfig [-dn] <String> [-connectorId] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the type and property values of a real time connector of the persistent cache at the DN.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheRealTimeConnectorConfig -dn 'o=hrdatabase' -connectorId 'northwind_APP.EMPLOYEES'
```

Returns the configuration of a real time connector of a cache at o=hrdatabase.

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

### psRadiantOne.CacheRealTimeConnectorConfig

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
