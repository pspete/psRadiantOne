---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1ControlPanelConfiguration

## SYNOPSIS
Updates the control panel configuration.

## SYNTAX

```
Set-R1ControlPanelConfiguration [[-dashboardColorTheme] <String>] [[-controlPanelTimeout] <Int32>]
 [[-lockControlPanel] <Boolean>] [[-maxConcurrentUsers] <Int32>] [[-bannerText] <String>]
 [[-bannerBackgroundColor] <String>] [[-bannerTextColor] <String>] [[-messageContent] <String>]
 [[-messageTitle] <String>] [[-warning] <Boolean>] [[-popup] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the control panel configuration, covering the colour theme, session timeout, concurrent user
limit, banner and message of the day.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1ControlPanelConfiguration -bannerText 'Production' -bannerBackgroundColor '#AA0000'
```

Sets a red banner reading Production.

### Example 2
```powershell
Set-R1ControlPanelConfiguration -controlPanelTimeout 15
```

Shortens the control panel idle timeout to fifteen minutes.

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

### -bannerBackgroundColor
The banner background colour, as a six digit hex value prefixed with #, or empty.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bannerText
The text shown in the control panel banner.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bannerTextColor
The banner text colour, as a six digit hex value prefixed with #, or empty.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -controlPanelTimeout
How long a control panel session may be idle, in minutes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dashboardColorTheme
The dashboard colour, as a six digit hex value prefixed with #.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lockControlPanel
Whether the control panel is locked to further logins.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -maxConcurrentUsers
The maximum number of concurrent control panel users. Zero for no limit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -messageContent
The body of the message of the day.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -messageTitle
The title of the message of the day.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -popup
Whether the message of the day is shown as a popup.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -warning
Whether the message of the day is styled as a warning.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Int32

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
