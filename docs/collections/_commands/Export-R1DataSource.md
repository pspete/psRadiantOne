---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1DataSource

## SYNOPSIS
Exports data sources to a zip file.

## SYNTAX

```
Export-R1DataSource [-dataSources] <String[]> [-performOpOnSchemas <Boolean>] [-crossEnvironment <Boolean>]
 [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Exports the named data sources and writes the archive into the given directory as datasources.zip.
The archive contains a datasources.json file, and may contain schema files alongside it. The file
that was written is returned.

## EXAMPLES

### Example 1
```powershell
Export-R1DataSource -dataSources 'opendj' -Path 'C:\backup'
```

Exports opendj into C:\backup as a zip archive, under the file name the server gives it.

### Example 2
```powershell
Export-R1DataSource -dataSources 'opendj', 'advworks' -Path 'C:\backup\datasources.zip'
```

Exports two data sources into a single archive with the name given.

### Example 3
```powershell
Export-R1DataSource -dataSources 'opendj' -performOpOnSchemas $false
```

Exports opendj without its schemas into the Downloads directory.

## PARAMETERS

### -dataSources
The names of the data sources to export.

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
The directory to save the file into, or the full path of the file.

Given a directory, the file is saved under the name the API sends it with. Given a full path, it
is saved under the name that path ends in. When not given, the file is saved to the current
user's Downloads directory, under the name the API sends it with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: The current user's Downloads directory
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -crossEnvironment
Exports in cross environment mode. Without it, the data sources are not usable outside this
environment. The API defaults this to true.

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

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Import-R1DataSource](Import-R1DataSource)

[Get-R1DataSource](Get-R1DataSource)
