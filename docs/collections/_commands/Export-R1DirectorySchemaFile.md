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
Export-R1DirectorySchemaFile [-fileName] <String> [-Path] <String> [<CommonParameters>]
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
The path of the local file to upload.

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

[Get-R1DirectorySchemaFile](Get-R1DirectorySchemaFile)

[Import-R1DirectorySchemaFile](Import-R1DirectorySchemaFile)
