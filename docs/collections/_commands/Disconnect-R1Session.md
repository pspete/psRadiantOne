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
Disconnect-R1Session [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Revokes the authentication token held in the module scope session, so that it can no longer be used
to perform any operation requiring authorization, and then clears the session.

Once run, Connect-R1Session must be used again before any other command in the module will work.

Revoking a token requires the SCOPE_AUTH_TOKEN_REVOKE scope, granted by a role holding
revokeTokenPermission. Where the revocation fails the token remains valid until it expires, so the
session is left in place and the failure reported, allowing the revocation to be retried. Specify
Force to clear the local session regardless, accepting that the token stays valid and can no longer
be revoked through this session.

## EXAMPLES

### Example 1
```powershell
Disconnect-R1Session
```

Revokes the current authentication token and clears the session.

### Example 2
```powershell
Disconnect-R1Session -Force
```

Clears the local session even where the token could not be revoked, warning that the token remains
valid until it expires.

## PARAMETERS

### -Force
Clear the local session even where the token could not be revoked. Without it, a failed revocation
is reported and the session left in place so that it can be retried.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
