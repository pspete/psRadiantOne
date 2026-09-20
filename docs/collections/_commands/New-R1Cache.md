---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1Cache

## SYNOPSIS
Creates a persistent cache of a naming context.

## SYNTAX

```
New-R1Cache [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a persistent cache of the naming context node identified by its DN. The cache is created
unconfigured: Set-R1CacheRefresh or Set-R1CacheRealTimeConnectorConfig sets how it is refreshed, and
Initialize-R1Cache fills it.

## EXAMPLES

### Example 1
```powershell
New-R1Cache -dn 'o=directory'
Set-R1CacheRefresh -dn 'o=directory' -refreshCronExpression '0 0/10 * * * ?'
Initialize-R1Cache -dn 'o=directory'
```

Caches o=directory, refreshes it every ten minutes, and fills it from a snapshot of the view.

## PARAMETERS

### -dn
The DN of the naming context node to cache.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### System.Void

## NOTES

## RELATED LINKS

[Get-R1Cache](Get-R1Cache)

[Set-R1CacheRefresh](Set-R1CacheRefresh)

[Initialize-R1Cache](Initialize-R1Cache)

[Set-R1CacheProperty](Set-R1CacheProperty)
