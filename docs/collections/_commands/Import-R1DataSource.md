---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1DataSource

## SYNOPSIS
Imports data sources from a file.

## SYNTAX

```
Import-R1DataSource [-Path] <String> [-overrideExisting <Boolean>] [-performOpOnSchemas <Boolean>]
 [-crossEnvironment <Boolean>] [-Xml] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a data source export and imports it. A JSON export is imported by default; use -Xml for an
XML one. The file is sent as multipart form data.

## EXAMPLES

### Example 1
```powershell
Import-R1DataSource -Path .\\datasources.json
```

Imports a JSON export.

### Example 2
```powershell
Import-R1DataSource -Path .\\datasources.xml -Xml
```

Imports an XML export.

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

### -Xml
Imports an XML export rather than a JSON one.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### -crossEnvironment
Imports in cross environment mode. Without it, data sources are not usable outside the environment
they were exported from. The API defaults this to true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -overrideExisting
Replaces a data source which already exists. Without it the API refuses the import with a bad
request when the file names a data source the deployment already has.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -performOpOnSchemas
Includes the schemas associated with the data sources. The API defaults this to true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[Export-R1DataSource](Export-R1DataSource)

[Get-R1DataSource](Get-R1DataSource)
