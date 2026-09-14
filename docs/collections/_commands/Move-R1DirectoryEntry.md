---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Move-R1DirectoryEntry

## SYNOPSIS
Moves an entry beneath another.

## SYNTAX

```
Move-R1DirectoryEntry [-dn] <String> [-newParentDn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Moves an entry to sit beneath a different parent, keeping its RDN.

## EXAMPLES

### Example 1
```powershell
Move-R1DirectoryEntry -dn 'uid=one,ou=old,o=example' -newParentDn 'ou=new,o=example'
```

Moves the entry to a different organizational unit.

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

### -newParentDn
The DN of the entry to move this one beneath.

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

## RELATED LINKS

[Rename-R1DirectoryEntry](Rename-R1DirectoryEntry)

[Set-R1DirectoryEntry](Set-R1DirectoryEntry)
