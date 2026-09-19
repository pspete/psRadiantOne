---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1CacheRealTimeConnectorDiagnostic

## SYNOPSIS
Returns the real time connector diagnostics of a cache.

## SYNTAX

```
Get-R1CacheRealTimeConnectorDiagnostic [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns whether real time connectors can be configured for the persistent cache at the DN, with a message explaining why not and the caches which would first be required.

## EXAMPLES

### Example 1
```powershell
Get-R1CacheRealTimeConnectorDiagnostic -dn 'o=directory'
```

Returns the real time connector diagnostics of a cache at o=directory.

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

### psRadiantOne.CacheRealTimeConnectorDiagnostic

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)
