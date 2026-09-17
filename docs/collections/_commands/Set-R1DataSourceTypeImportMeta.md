---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DataSourceTypeImportMeta

## SYNOPSIS
Updates a template in an upload session.

## SYNTAX

```
Set-R1DataSourceTypeImportMeta [-importId] <String> [-name] <String> [-DataSourceType] <Object> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces a template definition in an upload session with the one supplied. The definition sent is
the complete template, so retrieve it first with Get-R1DataSourceTypeImportMeta, change what you
need, and pass it back.

## EXAMPLES

### Example 1
```powershell
$Template = Get-R1DataSourceTypeImportMeta -importId 'imp1' -name 'My Custom'
$Template.description = 'Updated'
Set-R1DataSourceTypeImportMeta -importId 'imp1' -name 'My Custom' -DataSourceType $Template
```

Retrieves a template, changes it and sends it back.

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
The name of the data source type.

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

### -DataSourceType
The complete template definition.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
