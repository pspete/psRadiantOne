---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Disconnect-R1Session

## SYNOPSIS
Revokes the current authentication token and clears the session.

## SYNTAX

```
Disconnect-R1Session [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Revokes the authentication token held in the module scope session, so that it can no longer be used
to perform any operation requiring authorization, and then clears the session.

Once run, Connect-R1Session must be used again before any other command in the module will work.

## EXAMPLES

### Example 1
```powershell
Disconnect-R1Session
```

Revokes the current authentication token and clears the session.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
