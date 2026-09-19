---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1Cache

## SYNOPSIS
Deletes a persistent cache.

## SYNTAX

```
Remove-R1Cache [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes the persistent cache of the naming context node identified by its DN. The naming context
itself is left as it is, presenting its backend directly again.

## EXAMPLES

### Example 1
```powershell
Remove-R1Cache -dn 'o=directory'
```

Deletes the cache of o=directory, after prompting for confirmation.

### Example 2
```powershell
Invoke-R1CacheRealTimeConnectorScript -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -action DECONFIGURE
Remove-R1Cache -dn 'o=hr'
```

Removes the triggers and log table a real time connector put into its database, then deletes the
cache.

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

The scripts a real time connector ran against its data source are not undone by deleting the cache.
Run its DECONFIGURE scripts first with Invoke-R1CacheRealTimeConnectorScript.

## RELATED LINKS

[New-R1Cache](New-R1Cache)

[Get-R1Cache](Get-R1Cache)

[Invoke-R1CacheRealTimeConnectorScript](Invoke-R1CacheRealTimeConnectorScript)
