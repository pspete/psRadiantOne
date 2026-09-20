---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Add-R1DataSourcePlugin

## SYNOPSIS
Installs a data source plugin.

## SYNTAX

```
Add-R1DataSourcePlugin [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a plugin providing custom data source types. The file is sent as multipart form data.

The plugin is staged rather than installed: the returned object carries the id of the staged import,
along with the templates the plugin brings and the drivers they need. Complete-R1DataSourceTypeImport
installs it, and Remove-R1DataSourceTypeImport discards it.

## EXAMPLES

### Example 1
```powershell
$Staged = Add-R1DataSourcePlugin -Path .\connector.jar
Complete-R1DataSourceTypeImport -id $Staged.id -templates $Staged.newTemplates.name
```

Stages a plugin from a local jar, then installs the templates it brings.

## PARAMETERS

### -Path
The path of the local file to upload, or the directory to write the export into.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

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

### psRadiantOne.TemplateImport

## NOTES

## RELATED LINKS

[Get-R1DataSourcePlugin](Get-R1DataSourcePlugin)

[Remove-R1DataSourcePlugin](Remove-R1DataSourcePlugin)
