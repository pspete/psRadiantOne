---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1ChangeLogSetting

## SYNOPSIS
Updates the change log settings.

## SYNTAX

```
Set-R1ChangeLogSetting [[-enableChangelog] <Boolean>] [[-maxAge] <Int32>]
 [[-persistentCacheRefreshLog] <String>] [[-changelogs] <Hashtable[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the change log settings, covering whether the change log is enabled, how long entries are
retained, and the per-backend change log entries.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1ChangeLogSetting -enableChangelog $true -maxAge 30
```

Enables the change log and retains entries for 30 days.

## PARAMETERS

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

### -changelogs
The per-backend change log entries, each with a dn, a source of PROXY, PCACHE or HDAP, and an enabled flag.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enableChangelog
Whether the change log is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -maxAge
How long change log entries are retained, in days, up to 365.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -persistentCacheRefreshLog
How much persistent cache refresh activity is logged. all, error or status.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: all, error, status

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Boolean

### System.Int32

### System.String

### System.Collections.Hashtable[]

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
