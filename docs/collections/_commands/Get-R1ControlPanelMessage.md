---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1ControlPanelMessage

## SYNOPSIS
Returns a control panel message.

## SYNTAX

```
Get-R1ControlPanelMessage [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns either the control panel banner or the message of the day.

Both are also returned, and are set, through the control panel configuration.

## EXAMPLES

### Example 1
```powershell
Get-R1ControlPanelMessage -Type Banner
```

Returns the banner text and colours.

### Example 2
```powershell
Get-R1ControlPanelMessage -Type Motd
```

Returns the message of the day.

## PARAMETERS

### -Type
Which message to return. Banner or Motd.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Banner, Motd

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.ControlPanelMessage

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
