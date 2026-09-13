---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1DataSourceType

## SYNOPSIS
Exports data source type templates.

## SYNTAX

```
Export-R1DataSourceType [-templates] <String[]> [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Exports the named templates and writes the archive into the given directory as templates.zip. The
file that was written is returned.

## EXAMPLES

### Example 1
```powershell
Export-R1DataSourceType -templates 'My Custom' -Path 'C:\\backup'
```

Exports one template.

### Example 2
```powershell
Export-R1DataSourceType -templates 'My Custom', 'My Other' -Path 'C:\\backup'
```

Exports two templates into a single archive.

## PARAMETERS

### -templates
The names of the templates.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
The path of the local file to upload, or the directory to write the export into.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.FileInfo

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Import-R1DataSourceType](Import-R1DataSourceType)

[Get-R1DataSourceType](Get-R1DataSourceType)
