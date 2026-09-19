---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheRefresh

## SYNOPSIS
Returns the refresh settings of a cache.

## SYNTAX

```
Get-R1CacheRefresh [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns how the persistent cache at the DN is refreshed, and for a periodic refresh its schedule and validation thresholds.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheRefresh -dn 'o=directory'
```

Returns the refresh settings of a cache at o=directory.

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

### psRadiantOne.CacheRefresh

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
