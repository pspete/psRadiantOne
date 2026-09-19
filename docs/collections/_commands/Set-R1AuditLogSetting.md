---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1AuditLogSetting

## SYNOPSIS
Updates the audit logging configuration.

## SYNTAX

```
Set-R1AuditLogSetting [[-enabled] <Boolean>] [[-diffsEnabled] <Boolean>] [[-jsonEnabled] <Boolean>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the audit logging configuration.

The current configuration is retrieved before it is updated, and sent back with the supplied
values applied over it, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the
configuration as well as to change it.

## EXAMPLES

### Example 1
```powershell
Set-R1AuditLogSetting -enabled $true
```

Enables audit logging, leaving the other settings as they are.

### Example 2
```powershell
Set-R1AuditLogSetting -enabled $true -diffsEnabled $true -jsonEnabled $true
```

Enables audit logging, records the differences made by each change, and writes the log as JSON.

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

### -diffsEnabled
Whether the audit log records the differences made by a change.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enabled
Whether the validator is enabled.

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

### -jsonEnabled
Whether the audit log is written in JSON.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

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

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
