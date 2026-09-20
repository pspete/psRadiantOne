---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1CacheRealTimeConnectorScript

## SYNOPSIS
Downloads the scripts which prepare a data source for a real time connector.

## SYNTAX

```
Export-R1CacheRealTimeConnectorScript [-dn] <String> [-connectorId] <String> [-action] <String>
 [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Downloads, as a zip archive, the scripts which prepare the data source of a real time connector, or
undo that preparation, for them to be run by hand. The control panel offers them as Apply Later.

## EXAMPLES

### Example 1
```powershell
Export-R1CacheRealTimeConnectorScript -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -action CONFIGURE -Path 'C:\scripts\configure.zip'
```

Downloads the scripts which create the triggers and log table the connector needs.

### Example 2
```powershell
Export-R1CacheRealTimeConnectorScript -dn 'o=hr' -connectorId 'northwind_APP.EMPLOYEES' -action DECONFIGURE -Path 'C:\scripts\deconfigure.zip'
```

Downloads the scripts which remove them again.

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
Which scripts to download: CONFIGURE, which prepares the data source, or DECONFIGURE, which undoes
it.

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

### -Path
The directory or file to save the archive to. Without it, the archive is saved to the Downloads
directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.FileInfo

## NOTES

The server gives the archives of both actions the same name, taken from the cache, so a second
download into the same directory replaces the first. Name the file in -Path to keep both.

## RELATED LINKS

[Invoke-R1CacheRealTimeConnectorScript](Invoke-R1CacheRealTimeConnectorScript)

[Set-R1CacheRealTimeConnectorConfig](Set-R1CacheRealTimeConnectorConfig)
