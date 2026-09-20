---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1DataSourcePlugin

## SYNOPSIS
Removes a data source plugin.

## SYNTAX

```
Remove-R1DataSourcePlugin [-pluginName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the named plugin.

## EXAMPLES

### Example 1
```powershell
Remove-R1DataSourcePlugin -pluginName 'example'
```

Removes the plugin, after prompting for confirmation.

## PARAMETERS

### -pluginName
The name of the plugin.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

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

The API answers a successful removal with HTTP 500 and no error details. The command checks the
plugin listing when that happens: gone from the listing is treated as success, with a warning
rather than a terminating error, and an error is only raised when the plugin is still there.

## RELATED LINKS

[Get-R1DataSourcePlugin](Get-R1DataSourcePlugin)
