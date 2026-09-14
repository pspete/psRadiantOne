---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1DirectoryLdif

## SYNOPSIS
Imports an LDIF file into the directory.

## SYNTAX

### Local (Default)
```
Import-R1DirectoryLdif -Path <String> [-overwrite <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Server
```
Import-R1DirectoryLdif -filename <String> [-overwrite <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Imports entries from LDIF, either by uploading a local file or by naming one already on the server.
The import runs as a task, and the task it launched is returned.

## EXAMPLES

### Example 1
```powershell
Import-R1DirectoryLdif -Path .\\example.ldif
```

Uploads and imports a local LDIF file.

### Example 2
```powershell
Import-R1DirectoryLdif -filename 'example.ldif' -overwrite $true
```

Imports a file already on the server, overwriting entries which already exist.

## PARAMETERS

### -Path
The path of the local file to upload, or the directory to write the export into.

```yaml
Type: String
Parameter Sets: Local
Aliases: FullName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filename
The name of an LDIF file already on the server.

```yaml
Type: String
Parameter Sets: Server
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -overwrite
Overwrites entries which already exist.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### psRadiantOne.Task

## NOTES

The import runs as a task on the server. The task is returned, so its state can be followed with
Get-R1Task, and its log read with Get-R1TaskLog.

Where the task cannot be retrieved the import is already running, so its id is reported in a
warning and the launch response returned in place of the task.

## RELATED LINKS

[Export-R1DirectoryLdif](Export-R1DirectoryLdif)

[Get-R1DirectoryLdifFile](Get-R1DirectoryLdifFile)
