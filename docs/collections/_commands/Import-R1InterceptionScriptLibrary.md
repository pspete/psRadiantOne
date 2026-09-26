---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1InterceptionScriptLibrary

## SYNOPSIS
Uploads an external library.

## SYNTAX

```
Import-R1InterceptionScriptLibrary [-Path] <String> [[-isOverwrite] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uploads a local jar to the server for use by interception scripts, sending it as a multipart form.

Uploading over a library of the same name fails unless isOverwrite is specified.

## EXAMPLES

### Example 1
```powershell
Import-R1InterceptionScriptLibrary -Path .\someLib.jar
```

Uploads someLib.jar to the server.

### Example 2
```powershell
Import-R1InterceptionScriptLibrary -Path .\someLib.jar -isOverwrite $true
```

Uploads someLib.jar, replacing the library of that name already on the server.

## PARAMETERS

### -Path
The path of the local file to upload.

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

### -isOverwrite
Overwrites the file on the server when one of the same name already exists. Without it, uploading over an existing file fails.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### System.Void

## NOTES

## RELATED LINKS

[Get-R1InterceptionScriptLibrary](Get-R1InterceptionScriptLibrary)

[Remove-R1InterceptionScriptLibrary](Remove-R1InterceptionScriptLibrary)
