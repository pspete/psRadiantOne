---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1DirectorySchemaFile

## SYNOPSIS
Downloads a directory schema file.

## SYNTAX

```
Export-R1DirectorySchemaFile [-fileName] <String> [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Downloads a schema file from the server and writes it into the given directory, keeping the name
it has on the server. The file that was written is returned.

## EXAMPLES

### Example 1
```powershell
Export-R1DirectorySchemaFile -fileName 'ldapschema_14.ldif' -Path 'C:\\schema'
```

Downloads ldapschema_14.ldif into C:\\schema.

### Example 2
```powershell
Get-R1DirectorySchemaFile | ForEach-Object { Export-R1DirectorySchemaFile -fileName $PSItem -Path 'C:\\schema' }
```

Downloads every schema file on the server.

## PARAMETERS

### -fileName
The name of the schema file, which must end .ldif or .ldifz.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

[Get-R1DirectorySchemaFile](Get-R1DirectorySchemaFile)

[Import-R1DirectorySchemaFile](Import-R1DirectorySchemaFile)
