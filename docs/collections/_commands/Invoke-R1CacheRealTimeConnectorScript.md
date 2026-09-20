---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Invoke-R1CacheRealTimeConnectorScript

## SYNOPSIS
Runs the scripts which prepare a data source for a real time connector.

## SYNTAX

```
Invoke-R1CacheRealTimeConnectorScript [-dn] <String> [-connectorId] <String> [-action] <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Runs, on the data source itself, the scripts which prepare it for a real time connector, or undo that
preparation, and returns whether they succeeded. The control panel offers this as Apply Now.

## EXAMPLES

### Example 1
```powershell
Invoke-R1CacheRealTimeConnectorScript -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -action CONFIGURE
```

Creates the triggers and log table the connector needs, after prompting for confirmation.

### Example 2
```powershell
Invoke-R1CacheRealTimeConnectorScript -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -action DECONFIGURE
```

Removes them again, as is done before the cache is deleted.

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
The id of the real time connector, as Get-R1CacheRealTimeConnector returns it.

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

### -action
Which scripts to run: CONFIGURE, which prepares the data source, or DECONFIGURE, which undoes it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
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

### psRadiantOne.ScriptExecutionResult

## NOTES

The scripts change the data source itself, not only RadiantOne.

## RELATED LINKS

[Export-R1CacheRealTimeConnectorScript](Export-R1CacheRealTimeConnectorScript)

[Set-R1CacheRealTimeConnectorConfig](Set-R1CacheRealTimeConnectorConfig)
