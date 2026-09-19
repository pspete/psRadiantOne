---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1StoreData

## SYNOPSIS
Initializes a RadiantOne Directory store from an LDIF file.

## SYNTAX

```
Import-R1StoreData [-dn] <String> [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads an LDIF file and initializes the RadiantOne Directory store mounted at the naming context
node from it, replacing its current contents. The file is sent as multipart form data, and the task
running the import is returned.

## EXAMPLES

### Example 1
```powershell
$Task = Import-R1StoreData -dn 'o=store' -Path .\store.ldif
Get-R1TaskLog -id $Task.taskId -numberOfLines 15
```

Initializes the store from a local LDIF file, after prompting for confirmation, and shows the end of
the log of the task doing it.

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
The LDIF file to upload. Its entries must lie beneath the DN of the store, which it should
include.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

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

### psRadiantOne.LaunchedTask

## NOTES

## RELATED LINKS

[Backup-R1Store](Backup-R1Store)

[Import-R1StoreBackup](Import-R1StoreBackup)

[Get-R1TaskLog](Get-R1TaskLog)
