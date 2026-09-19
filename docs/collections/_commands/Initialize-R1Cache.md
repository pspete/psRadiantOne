---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Initialize-R1Cache

## SYNOPSIS
Initializes a persistent cache from a snapshot of its view.

## SYNTAX

```
Initialize-R1Cache [-dn] <String> [[-useLdifz] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Fills a persistent cache from a snapshot of the virtual view it caches, as the control panel does when
its snapshot option is chosen, and returns the task doing it.

## EXAMPLES

### Example 1
```powershell
$Task = Initialize-R1Cache -dn 'o=directory'
Get-R1TaskLog -id $Task.taskId -numberOfLines 15
```

Initializes the cache at o=directory and shows the end of the log of the task doing it.

## PARAMETERS

### -dn
The DN of the cache.

```yaml
Type: String
Parameter Sets: (All)
Aliases: label

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useLdifz
Whether the snapshot is written as a compressed LDIFZ file.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
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

The API also initializes a cache from an LDIF file already on the server, which this command does
not do.

## RELATED LINKS

[New-R1Cache](New-R1Cache)

[Import-R1Cache](Import-R1Cache)

[Get-R1TaskLog](Get-R1TaskLog)
