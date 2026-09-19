---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheProperty

## SYNOPSIS
Returns the properties of a cache.

## SYNTAX

```
Get-R1CacheProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of the persistent cache at the DN, including its suffixes, whether it is used for authentication and password policy enforcement, the attributes which are indexed, sorted, encrypted and compared case sensitively, and its replication and changelog settings.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheProperty -dn 'o=directory'
```

Returns the properties of a cache at o=directory.

### Example 2
```powershell
Get-R1Cache | Get-R1CacheProperty
```

Returns the properties of every cache.

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

### psRadiantOne.CacheProperties

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
