---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Cache

## SYNOPSIS
Returns persistent caches.

## SYNTAX

### All (Default)
```
Get-R1Cache [-baseDn <String>] [<CommonParameters>]
```

### Dn
```
Get-R1Cache -dn <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the persistent caches configured in the directory namespace, each with its refresh type and
whether it is active, configured and initialized.

Specify a DN to return a single cache, or a base DN to return only the caches at or below it. When
neither is specified, every cache is returned.

## EXAMPLES

### Example 1
```powershell
Get-R1Cache
```

Returns every cache.

### Example 2
```powershell
Get-R1Cache -dn 'o=directory'
```

Returns the cache at o=directory.

### Example 3
```powershell
Get-R1Cache | Get-R1CacheRefresh
```

Returns the refresh settings of every cache.

## PARAMETERS

### -dn
The DN of the cache.

```yaml
Type: String
Parameter Sets: Dn
Aliases: label

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
Returns only the caches at or below this DN.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Cache

## NOTES

## RELATED LINKS

[Get-R1CacheProperty](Get-R1CacheProperty)

[Get-R1CacheRefresh](Get-R1CacheRefresh)

[Get-R1CacheRealTimeConnector](Get-R1CacheRealTimeConnector)
