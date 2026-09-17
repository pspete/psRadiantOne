---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1File

## SYNOPSIS
Downloads files from the server.

## SYNTAX

```
Export-R1File [-files] <String[]> [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Downloads one or more files and writes them into the given directory. A single file is written
under its own name; several come back as an archive written as files.zip. The file that was
written is returned.

## EXAMPLES

### Example 1
```powershell
Export-R1File -files '/conf/app.properties' -Path 'C:\\backup'
```

Downloads one file.

### Example 2
```powershell
Export-R1File -files '/conf/one.txt', '/conf/two.txt' -Path 'C:\\backup'
```

Downloads two files as an archive.

## PARAMETERS

### -files
The paths of the files to download.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: file

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Import-R1File](Import-R1File)

[Get-R1FileContent](Get-R1FileContent)
