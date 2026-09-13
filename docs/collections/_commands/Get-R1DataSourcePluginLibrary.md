---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourcePluginLibrary

## SYNOPSIS
Returns the libraries a plugin depends on.

## SYNTAX

```
Get-R1DataSourcePluginLibrary [-pluginName] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the library references a plugin depends on, each identified by its Maven coordinates.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSourcePluginLibrary -pluginName 'example'
```

Returns the libraries the plugin depends on.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.LibraryReference

## NOTES

## RELATED LINKS

[Set-R1DataSourcePluginLibrary](Set-R1DataSourcePluginLibrary)

[Get-R1DataSourcePlugin](Get-R1DataSourcePlugin)
