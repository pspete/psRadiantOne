---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourcePluginClass

## SYNOPSIS
Returns the classes a plugin provides.

## SYNTAX

### Installed (Default)
```
Get-R1DataSourcePluginClass -pluginName <String> [<CommonParameters>]
```

### Import
```
Get-R1DataSourcePluginClass -pluginName <String> -importId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the Java classes a plugin provides, either for an installed plugin or for one in an upload
session which has not been imported yet.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourcePluginClass -pluginName 'example'
```

Returns the classes of an installed plugin.

### Example 2
```powershell
Get-R1DataSourcePluginClass -pluginName 'example' -importId 'imp1'
```

Returns the classes of a plugin in an upload session.

## PARAMETERS

### -pluginName
The name of the plugin.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -importId
The identifier of the upload session, as returned by Import-R1DataSourceType.

```yaml
Type: String
Parameter Sets: Import
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Get-R1DataSourcePlugin](Get-R1DataSourcePlugin)

[New-R1DataSourceType](New-R1DataSourceType)
