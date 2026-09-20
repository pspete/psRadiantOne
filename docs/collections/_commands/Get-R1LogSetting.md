---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LogSetting

## SYNOPSIS
Returns the log settings of a component.

## SYNTAX

### Component (Default)
```
Get-R1LogSetting -component <String> [<CommonParameters>]
```

### DataSource
```
Get-R1LogSetting -dsName <String> [<CommonParameters>]
```

### Plugin
```
Get-R1LogSetting -pluginName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the log settings of a component, a data source or a plugin.

The component names are fixed by the API and several contain spaces, so they are escaped into the
request path. Data sources and plugins are addressed by name on their own paths instead.

What a component returns varies: the API defines seven shapes keyed by logSettingsComponent, from
a plugin carrying only a log level to the LDAP access component carrying eighteen properties.

## EXAMPLES

### Example 1
```powershell
Get-R1LogSetting -component 'RadiantOne Server'
```

Returns the log settings of the RadiantOne Server component.

### Example 2
```powershell
Get-R1LogSetting -dsName 'SomeDataSource'
```

Returns the log settings of a data source.

### Example 3
```powershell
Get-R1LogSetting -pluginName 'SomePlugin'
```

Returns the log settings of a plugin.

## PARAMETERS

### -component
The log settings component. One of the thirteen names the API defines, several of which contain spaces.

```yaml
Type: String
Parameter Sets: Component
Aliases:
Accepted values: RadiantOne Server, Persistent Cache Periodic Refresh, ADAP Access, Sync Engine, SCIM, Scheduler Server, Scheduler Tasks, Control Panel Server, Control Panel Access, Control Panel Context Builder Audit, Common User, Sync Agents, RadiantOne LDAP Access

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dsName
The name of the data source whose log settings are addressed.

```yaml
Type: String
Parameter Sets: DataSource
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pluginName
The name of the plugin whose log settings are addressed.

```yaml
Type: String
Parameter Sets: Plugin
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

### System.String

## OUTPUTS

### psRadiantOne.LogSettings

## NOTES

The Component and Plugin sets both return real settings against a live deployment. The DataSource
set has not: on a deployment tried so far it answers HTTP 500 with no error details for every data
source name given, including one which does not exist. The API restricts this set to a custom type
data source, and none tried has been a genuine one.

## RELATED LINKS
