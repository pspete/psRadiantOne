---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1CacheRefresh

## SYNOPSIS
Sets a persistent cache to refresh periodically.

## SYNTAX

```
Set-R1CacheRefresh [-dn] <String> [-refreshCronExpression] <String> [[-validationScriptPath] <String>]
 [[-addValidationThreshold] <Int32>] [[-deleteValidationThreshold] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sets a persistent cache to be refreshed on a schedule. The validation script and thresholds the cache
already has are kept unless they are specified.

## EXAMPLES

### Example 1
```powershell
Set-R1CacheRefresh -dn 'o=directory' -refreshCronExpression '0 0/10 * * * ?'
```

Refreshes the cache at o=directory every ten minutes.

### Example 2
```powershell
Get-R1Cache | Where-Object refreshType -EQ 'PERIODIC' | Set-R1CacheRefresh -refreshCronExpression '0 0 2 * * ?'
```

Moves the refresh of every periodically refreshed cache to 2am.

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

### -refreshCronExpression
When the cache is refreshed, as a Quartz cron expression: seconds, minutes, hours, day of the month,
month and day of the week.

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

### -validationScriptPath
A script which validates the refreshed data before it replaces the cache.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -addValidationThreshold
The largest number of entries a refresh may add before it is refused.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -deleteValidationThreshold
The largest number of entries a refresh may delete before it is refused.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
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

Only a periodic refresh can be set with this command. A real time refresh is configured through the
connectors of the cache, with Set-R1CacheRealTimeConnectorConfig.

## RELATED LINKS

[Get-R1CacheRefresh](Get-R1CacheRefresh)

[New-R1Cache](New-R1Cache)

[Set-R1CacheRealTimeConnectorConfig](Set-R1CacheRealTimeConnectorConfig)
