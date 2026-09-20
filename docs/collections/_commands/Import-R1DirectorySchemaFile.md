---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1DirectorySchemaFile

## SYNOPSIS
Imports a directory schema file.

## SYNTAX

### Local (Default)
```
Import-R1DirectorySchemaFile -Path <String> [-isOverride <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Server
```
Import-R1DirectorySchemaFile -file <String> [-addBehavior <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Imports schema from an LDIF file, either by uploading one from the local machine or by naming a
file already present on the server.

A local file is sent as multipart form data, and isOverride controls whether existing entries are
overwritten. A server file is named instead, and addBehavior controls the same thing.

## EXAMPLES

### Example 1
```powershell
Import-R1DirectorySchemaFile -Path .\custom.ldif
```

Uploads and imports a local schema file.

### Example 2
```powershell
Import-R1DirectorySchemaFile -Path .\custom.ldif -isOverride $true
```

Uploads and imports a local schema file, overwriting entries which already exist.

### Example 3
```powershell
Import-R1DirectorySchemaFile -file 'ldapschema_14.ldif' -addBehavior 'ADD_OR_OVERRIDE'
```

Imports a schema file already on the server, overwriting entries which already exist.

## PARAMETERS

### -Path
The path of the local file to upload.

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

### -isOverride
Overwrites entries which already exist. Without it, importing over an existing entry fails.

```yaml
Type: Boolean
Parameter Sets: Local
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -file
The name of a schema file already present on the server.

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

### -addBehavior
Whether existing entries are left alone or overwritten.

```yaml
Type: String
Parameter Sets: Server
Aliases:

Required: False
Position: Named
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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DirectorySchemaFile](Get-R1DirectorySchemaFile)

[Export-R1DirectorySchemaFile](Export-R1DirectorySchemaFile)
