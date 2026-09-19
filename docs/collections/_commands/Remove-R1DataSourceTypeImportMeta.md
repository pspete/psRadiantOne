---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1DataSourceTypeImportMeta

## SYNOPSIS
Removes a template from an upload session.

## SYNTAX

```
Remove-R1DataSourceTypeImportMeta [-importId] <String> [-name] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a template definition from an upload session before the session is imported.

## EXAMPLES

### Example 1
```powershell
Remove-R1DataSourceTypeImportMeta -importId $Session.id -name 'My Custom Copy'
```

Removes a template from a staged import, after prompting for confirmation. The rest of the import is
left as it is.

## PARAMETERS

### -importId
The identifier of the upload session, as returned by Import-R1DataSourceType.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the template.

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

## RELATED LINKS

[Get-R1DataSourceTypeImportMeta](Get-R1DataSourceTypeImportMeta)

[Remove-R1DataSourceTypeImport](Remove-R1DataSourceTypeImport)
