---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1DirectoryEntry

## SYNOPSIS
Deletes an entry from the directory.

## SYNTAX

```
Remove-R1DirectoryEntry [-dn] <String> [[-deleteSubNodes] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes the entry at the given DN. An entry with children cannot be deleted unless
deleteSubNodes is specified, in which case the whole subtree goes with it.

## EXAMPLES

### Example 1
```powershell
Remove-R1DirectoryEntry -dn 'uid=one,o=example'
```

Deletes one entry, after prompting for confirmation.

### Example 2
```powershell
Remove-R1DirectoryEntry -dn 'ou=people,o=example' -deleteSubNodes $true
```

Deletes an entry and everything beneath it.

## PARAMETERS

### -dn
The DN of the entry.

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

### -deleteSubNodes
Deletes the entry together with everything beneath it. Without it, an entry with children cannot be deleted.

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

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)
