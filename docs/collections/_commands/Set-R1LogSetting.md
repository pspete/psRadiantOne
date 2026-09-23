---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1LogSetting

## SYNOPSIS
Updates the log settings of a component.

## SYNTAX

### Component (Default)
```
Set-R1LogSetting -component <String> [-logLevel <String>] [-rolloverSize <String>]
 [-archiveMaxFileCount <Int64>] [-integrityAssurance <Boolean>] [-advancedProperties <Object[]>]
 [-enableDebugSSL <Boolean>] [-logNotificationFailure <Boolean>] [-accessLogTextFormat <String>]
 [-accessLogCsvFormat <String>] [-addColumnNamesHeadersToCsv <Boolean>]
 [-ignoreAccessLogsNamingContext <String>] [-textDestination <String>] [-textRolloverDestination <String>]
 [-textDeleteGlob <String>] [-scanFolder <String>] [-csvDestination <String>]
 [-csvRolloverDestination <String>] [-csvDeleteGlob <String>] [-bufferSizeForFileLogging <Int32>]
 [-useIsoFormat <Boolean>] [-timezone <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DataSource
```
Set-R1LogSetting -dsName <String> [-logLevel <String>] [-rolloverSize <String>] [-archiveMaxFileCount <Int64>]
 [-integrityAssurance <Boolean>] [-advancedProperties <Object[]>] [-enableDebugSSL <Boolean>]
 [-logNotificationFailure <Boolean>] [-accessLogTextFormat <String>] [-accessLogCsvFormat <String>]
 [-addColumnNamesHeadersToCsv <Boolean>] [-ignoreAccessLogsNamingContext <String>] [-textDestination <String>]
 [-textRolloverDestination <String>] [-textDeleteGlob <String>] [-scanFolder <String>]
 [-csvDestination <String>] [-csvRolloverDestination <String>] [-csvDeleteGlob <String>]
 [-bufferSizeForFileLogging <Int32>] [-useIsoFormat <Boolean>] [-timezone <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Plugin
```
Set-R1LogSetting -pluginName <String> [-logLevel <String>] [-rolloverSize <String>]
 [-archiveMaxFileCount <Int64>] [-integrityAssurance <Boolean>] [-advancedProperties <Object[]>]
 [-enableDebugSSL <Boolean>] [-logNotificationFailure <Boolean>] [-accessLogTextFormat <String>]
 [-accessLogCsvFormat <String>] [-addColumnNamesHeadersToCsv <Boolean>]
 [-ignoreAccessLogsNamingContext <String>] [-textDestination <String>] [-textRolloverDestination <String>]
 [-textDeleteGlob <String>] [-scanFolder <String>] [-csvDestination <String>]
 [-csvRolloverDestination <String>] [-csvDeleteGlob <String>] [-bufferSizeForFileLogging <Int32>]
 [-useIsoFormat <Boolean>] [-timezone <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the log settings of a component, a data source or a plugin.

Log settings are polymorphic: each component carries a different set of properties, and the API
identifies which by the logSettingsComponent discriminator. Rather than model all seven shapes,
the command retrieves whichever one the component uses and applies the supplied values over it.
The properties belonging to that component are therefore preserved, and no property foreign to it
is introduced. It follows that the parameters accepted here are the union of every component's
properties, and that only those belonging to the component being addressed are meaningful.

The command issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1LogSetting -component 'Sync Engine' -logLevel DEBUG
```

Raises the Sync Engine log level to DEBUG.

### Example 2
```powershell
Set-R1LogSetting -component 'RadiantOne LDAP Access' -rolloverSize '200MB' -archiveMaxFileCount 20
```

Changes the access log rollover size and archive count, leaving its other properties as they are.

### Example 3
```powershell
Set-R1LogSetting -dsName 'SomeDataSource' -logLevel TRACE
```

Raises the log level of a data source.

### Example 4
```powershell
Set-R1LogSetting -component 'RadiantOne Server' -advancedProperties @{ 'some.property' = 'somevalue' }
```

Sets an advanced logging property.

## PARAMETERS

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

### -accessLogCsvFormat
The format of the CSV access log. Applies to the RadiantOne LDAP Access component.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accessLogTextFormat
The format of the text access log. Applies to the RadiantOne LDAP Access component.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -addColumnNamesHeadersToCsv
Whether the CSV access log carries a header row.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -advancedProperties
Advanced logging properties, as a hashtable keyed by property name.

Properties already in the shape the API takes them, each with key and value properties, are sent
unchanged.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -archiveMaxFileCount
How many archived log files are kept.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bufferSizeForFileLogging
The buffer size used when writing logs to file.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

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

### -csvDeleteGlob
A glob matching CSV access logs to delete.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -csvDestination
Where the CSV access log is written.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -csvRolloverDestination
Where rolled over CSV access logs are moved to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### -enableDebugSSL
Whether SSL debug output is enabled. Applies to the RadiantOne Server component.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ignoreAccessLogsNamingContext
A naming context excluded from the access log.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -integrityAssurance
Whether log integrity assurance is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -logLevel
The logging level. OFF, FATAL, ERROR, WARN, INFO, DEBUG or TRACE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: OFF, FATAL, ERROR, WARN, INFO, DEBUG, TRACE

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -logNotificationFailure
Whether notification failures are logged. Applies to the RadiantOne Server component.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
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

### -rolloverSize
The size at which a log file rolls over, e.g. 100MB.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scanFolder
The folder scanned for access logs.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -textDeleteGlob
A glob matching text access logs to delete.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -textDestination
Where the text access log is written.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -textRolloverDestination
Where rolled over text access logs are moved to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -timezone
The time zone timestamps are written in. Get-R1LogTimezone returns the available values.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useIsoFormat
Whether timestamps are written in ISO format.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Int64

### System.Boolean

### System.Object[]

### System.Int32

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
