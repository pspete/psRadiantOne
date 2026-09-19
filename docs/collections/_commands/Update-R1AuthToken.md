---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Update-R1AuthToken

## SYNOPSIS
Refreshes the authentication token held in the session.

## SYNTAX

```
Update-R1AuthToken [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Requests a replacement for an authentication token which is about to expire, and updates the module
scope session with the new token and the claims it carries.

The expiry of the current token is available from the TokenExpiry property returned by Get-R1Session.

## EXAMPLES

### Example 1
```powershell
Update-R1AuthToken
```

Replaces the session token with a freshly issued one.

### Example 2
```powershell
if ($(Get-R1Session).TokenExpiry -lt (Get-Date).AddMinutes(5)) { Update-R1AuthToken }
```

Refreshes the token only when it is within five minutes of expiring.

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

### System.Void

## NOTES

## RELATED LINKS
