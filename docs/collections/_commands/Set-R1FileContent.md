---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1FileContent

## SYNOPSIS
Replaces the contents of a file on the server.

## SYNTAX

```
Set-R1FileContent [-id] <String> [-contents] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Writes new text contents to a file.

## EXAMPLES

### Example 1
```powershell
Set-R1FileContent -id '/conf/app.properties' -contents (Get-Content .\\app.properties -Raw)
```

Replaces a file with the contents of a local one.

## PARAMETERS

### -id
The path of the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: file

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -contents
The complete new contents of the file.

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

The contents supplied replace the file entirely. Retrieve the current contents with
Get-R1FileContent first if only part is changing.

## RELATED LINKS

[Get-R1FileContent](Get-R1FileContent)

[Import-R1File](Import-R1File)
