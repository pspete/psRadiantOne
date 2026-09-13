---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DataSourcePluginLibrary

## SYNOPSIS
Sets the libraries a plugin depends on.

## SYNTAX

```
Set-R1DataSourcePluginLibrary [-pluginName] <String> [-libraries] <Object[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the library references a plugin depends on with the collection supplied.

## EXAMPLES

### Example 1
```powershell
$Libraries = Get-R1DataSourcePluginLibrary -pluginName 'example'
Set-R1DataSourcePluginLibrary -pluginName 'example' -libraries ($Libraries + $Extra)
```

Adds a library by retrieving the current collection and passing back the whole of it.

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

### -libraries
The complete collection of library references the plugin depends on.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

The libraries supplied replace those configured, so one left out is removed.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSourcePluginLibrary](Get-R1DataSourcePluginLibrary)
