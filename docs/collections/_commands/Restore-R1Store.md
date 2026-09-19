---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Restore-R1Store

## SYNOPSIS
Restores a RadiantOne Directory store from one of its backups.

## SYNTAX

```
Restore-R1Store [-dn] <String> [-backupId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Restores the RadiantOne Directory store mounted at the naming context node from a backup kept on the
server, replacing its current contents.

## EXAMPLES

### Example 1
```powershell
Restore-R1Store -dn 'o=store' -backupId '2026-09-19_17-50-33'
```

Restores the store from the backup taken at that time, after prompting for confirmation.

### Example 2
```powershell
Get-R1StoreBackup -dn 'o=store' | Select-Object -Last 1 | Restore-R1Store -dn 'o=store'
```

Restores the store from the last of its backups to be listed.

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

### -backupId
The id of the backup, as Get-R1StoreBackup returns it.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

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

[Get-R1StoreBackup](Get-R1StoreBackup)

[Backup-R1Store](Backup-R1Store)

[Import-R1StoreBackup](Import-R1StoreBackup)
