---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1DataSourceType

## SYNOPSIS
Uploads data source type templates.

## SYNTAX

```
Import-R1DataSourceType [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads an archive of data source type templates and returns the upload session it created.
Nothing is imported yet: inspect the session with Get-R1DataSourceTypeImport, then import the
templates you want with Complete-R1DataSourceTypeImport, or discard it with
Remove-R1DataSourceTypeImport.

## EXAMPLES

### Example 1
```powershell
Import-R1DataSourceType -Path .\\templates.zip
```

Uploads an archive and returns the upload session.

### Example 2
```powershell
$Session = Import-R1DataSourceType -Path .\\templates.zip
Get-R1DataSourceTypeImportMeta -importId $Session.id
```

Uploads an archive and lists the templates it contains.

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

[Get-R1DataSourceTypeImport](Get-R1DataSourceTypeImport)

[Complete-R1DataSourceTypeImport](Complete-R1DataSourceTypeImport)

[Remove-R1DataSourceTypeImport](Remove-R1DataSourceTypeImport)
