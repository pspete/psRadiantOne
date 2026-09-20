---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1CacheRealTimeConnectorConfig

## SYNOPSIS
Configures a real time connector of a persistent cache.

## SYNTAX

```
Set-R1CacheRealTimeConnectorConfig [-dn] <String> [-connectorId] <String> [[-type] <String>]
 [[-properties] <IDictionary>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Configures how a real time connector detects changes in its data source. The connector keeps the type
and properties it has, with the values given replacing theirs. A connector which is not configured
yet, or is given another type, starts from the properties that type offers, as
Get-R1CacheRealTimeConnectorType lists them.

Every property value is sent as a string, as the API returns them. A SecureString value is decoded
for the request, which is sent as bytes since the configuration carries the connector's password.

## EXAMPLES

### Example 1
```powershell
$Password = Read-Host -Prompt 'Log table password' -AsSecureString
Set-R1CacheRealTimeConnectorConfig -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -type 'DB_TRIGGER' -properties @{ logTableUser = 'RLI_CON'; logTableUserPassword = $Password }
```

Configures the connector for the APP.EMPLOYEES table to detect changes through a database change log,
read as the RLI_CON user.

### Example 2
```powershell
Set-R1CacheRealTimeConnectorConfig -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -properties @{ pollingInterval = 10000 }
```

Polls for changes every ten seconds, leaving the rest of the configuration as it is.

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

### -type
The connector type, as Get-R1CacheRealTimeConnectorType names it, for example DB_TRIGGER for a
database change log. Required for a connector which is not configured yet.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -properties
The property values to set, keyed by property name. A name the connector type does not have is
refused, with the names it does have.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: @{ }
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

### System.Void

## NOTES

The scripts which prepare the data source for the connector, such as the triggers and log table of a
database change log, are run with Invoke-R1CacheRealTimeConnectorScript.

## RELATED LINKS

[Get-R1CacheRealTimeConnectorConfig](Get-R1CacheRealTimeConnectorConfig)

[Get-R1CacheRealTimeConnectorType](Get-R1CacheRealTimeConnectorType)

[Invoke-R1CacheRealTimeConnectorScript](Invoke-R1CacheRealTimeConnectorScript)
