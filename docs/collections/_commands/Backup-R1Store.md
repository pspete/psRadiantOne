---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Backup-R1Store

## SYNOPSIS
Backs up a RadiantOne Directory store.

## SYNTAX

```
Backup-R1Store [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Takes a backup of the RadiantOne Directory store mounted at the naming context node. The backup is
kept on the server, where Get-R1StoreBackup lists it.

## EXAMPLES

### Example 1
```powershell
Backup-R1Store -dn 'o=store'
Get-R1StoreBackup -dn 'o=store'
```

Backs up the store and lists its backups.

## PARAMETERS

### -dn
The DN of the store.

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

[Get-R1StoreBackup](Get-R1StoreBackup)

[Export-R1StoreBackup](Export-R1StoreBackup)

[Restore-R1Store](Restore-R1Store)
