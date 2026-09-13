---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DataSourceTypeImportMeta

## SYNOPSIS
Adds a template to an upload session.

## SYNTAX

```
New-R1DataSourceTypeImportMeta [-importId] <String> [-DataSourceType] <Object> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds a template definition to an upload session, before the session is imported.

## EXAMPLES

### Example 1
```powershell
$Definition = [pscustomobject]@{ name = 'My Custom'; backendCategory = 'custom'; javaClassName = 'com.example.Connector' }
New-R1DataSourceTypeImportMeta -importId 'imp1' -DataSourceType $Definition
```

Adds a custom template to the session.

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

### -DataSourceType
The complete template definition.

```yaml
Type: Object
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

### psRadiantOne.DataSourceType

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSourceTypeImportMeta](Get-R1DataSourceTypeImportMeta)

[Set-R1DataSourceTypeImportMeta](Set-R1DataSourceTypeImportMeta)
