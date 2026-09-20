---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1StoreBackup

## SYNOPSIS
Downloads the backup of a RadiantOne Directory store.

## SYNTAX

```
Export-R1StoreBackup [-dn] <String> [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Downloads the backup of the RadiantOne Directory store mounted at the naming context node as a zip
archive.

## EXAMPLES

### Example 1
```powershell
Backup-R1Store -dn 'o=store'
Export-R1StoreBackup -dn 'o=store' -Path 'C:\backup'
```

Backs up the store and downloads the backup into C:\backup.

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

### -Path
The directory or file to save the archive to. Without it, the archive is saved to the Downloads
directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Backup-R1Store](Backup-R1Store)

[Import-R1StoreBackup](Import-R1StoreBackup)
