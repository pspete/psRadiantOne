---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Rename-R1DirectoryEntry

## SYNOPSIS
Changes the RDN of an entry.

## SYNTAX

```
Rename-R1DirectoryEntry [-dn] <String> [-newRdn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Renames an entry by changing its relative distinguished name, leaving it in the same place in the tree.

## EXAMPLES

### Example 1
```powershell
Rename-R1DirectoryEntry -dn 'uid=one,o=example' -newRdn 'uid=first'
```

Renames the entry to uid=first.

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

### -newRdn
The new RDN for the entry.

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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Move-R1DirectoryEntry](Move-R1DirectoryEntry)

[Set-R1DirectoryEntry](Set-R1DirectoryEntry)
