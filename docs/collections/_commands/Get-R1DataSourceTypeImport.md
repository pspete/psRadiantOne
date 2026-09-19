---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DataSourceTypeImport

## SYNOPSIS
Returns an upload session.

## SYNTAX

```
Get-R1DataSourceTypeImport [-id] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the upload session created by Import-R1DataSourceType, and the templates it holds.

## EXAMPLES

### Example 1
```powershell
$Session = Import-R1DataSourceType -Path .\templates.zip
Get-R1DataSourceTypeImport -id $Session.id
```

Returns the staged import again, with its new and conflicting templates and the drivers they need.

## PARAMETERS

### -id
The identifier of the upload session, as returned by Import-R1DataSourceType.

```yaml
Type: String
Parameter Sets: (All)
Aliases: importId

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

### psRadiantOne.TemplateImport

## NOTES

## RELATED LINKS

[Import-R1DataSourceType](Import-R1DataSourceType)

[Complete-R1DataSourceTypeImport](Complete-R1DataSourceTypeImport)
