---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1DirectoryLdifFile

## SYNOPSIS
Deletes an LDIF file from the server.

## SYNTAX

```
Remove-R1DirectoryLdifFile [-fileName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes the named LDIF file from the server.

## EXAMPLES

### Example 1
```powershell
Remove-R1DirectoryLdifFile -fileName 'companydirectory.ldif'
```

Deletes the file, after prompting for confirmation.

### Example 2
```powershell
Get-R1DirectoryLdifFile | ForEach-Object { Remove-R1DirectoryLdifFile -fileName $PSItem }
```

Deletes every LDIF file on the server, including the ones Save-R1DirectoryLdif leaves behind under
generated names, prompting for confirmation of each.

## PARAMETERS

### -fileName
The name of the LDIF file, which must end .ldif or .ldifz.

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

[Get-R1DirectoryLdifFile](Get-R1DirectoryLdifFile)
