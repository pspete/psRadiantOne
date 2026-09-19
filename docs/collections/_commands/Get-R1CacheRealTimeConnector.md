---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheRealTimeConnector

## SYNOPSIS
Returns the real time connectors of a cache.

## SYNTAX

```
Get-R1CacheRealTimeConnector [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the connectors which detect changes in the sources of the persistent cache at the DN, each with its data source, type, connector id and whether it is configured.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheRealTimeConnector -dn 'o=MyProfile'
```

Returns the real time connectors of a cache at o=MyProfile.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.CacheRealTimeConnector

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
