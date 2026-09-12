---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1InterceptionScript

## SYNOPSIS
Uploads an interception script.

## SYNTAX

```
Import-R1InterceptionScript [-Path] <String> [[-isOverwrite] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Uploads a local interception script file to the server, sending it as a multipart form.

Uploading over a script of the same name fails unless isOverwrite is specified.

## EXAMPLES

### Example 1
```powershell
Import-R1InterceptionScript -Path .\MyInterception.java
```

Uploads MyInterception.java to the server.

### Example 2
```powershell
Import-R1InterceptionScript -Path .\MyInterception.java -isOverwrite $true
```

Uploads MyInterception.java, replacing the script of that name already on the server.

### Example 3
```powershell
Get-ChildItem .\scripts\*.java | Import-R1InterceptionScript
```

Uploads every java file in the scripts folder.

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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1InterceptionScript](Get-R1InterceptionScript)

[Remove-R1InterceptionScript](Remove-R1InterceptionScript)

[New-R1InterceptionScriptJar](New-R1InterceptionScriptJar)
