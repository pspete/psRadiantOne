---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1File

## SYNOPSIS
Deletes files from the server.

## SYNTAX

```
Remove-R1File [-filePaths] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes one or more files in a single request.

## EXAMPLES

### Example 1
```powershell
Remove-R1File -filePaths '/conf/old.txt'
```

Deletes one file, after prompting for confirmation.

### Example 2
```powershell
Remove-R1File -filePaths '/conf/one.txt', '/conf/two.txt'
```

Deletes two files in one request.

## PARAMETERS

### -filePaths
The paths of the files to delete.

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

[Get-R1FileManagerDirectory](Get-R1FileManagerDirectory)
