---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Reset-R1Password

## SYNOPSIS
Resets an expired password using a reset token.

## SYNTAX

```
Reset-R1Password [-resetToken] <String> [-newPassword] <SecureString> [[-currentPassword] <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Completes the expired-password flow started by Connect-R1Session. The reset token returned by that
command is supplied together with the desired new password and, where the applicable password policy
requires it, the user's current password.

The reset token is single-use and is invalidated once the reset succeeds. After a successful reset,
authenticate again with Connect-R1Session.

## EXAMPLES

### Example 1
```powershell
Reset-R1Password -resetToken $reset.resetToken -newPassword $newSecureString
```

Sets a new password using the reset token issued by Connect-R1Session.

### Example 2
```powershell
Reset-R1Password -resetToken $reset.resetToken -newPassword $newSecureString -currentPassword $oldSecureString
```

Sets a new password where the password policy requires the current password to be supplied.

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

### -currentPassword
The current, expired password, as a SecureString. Required only when the login response reported requireCurrentPassword as true.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -newPassword
The new password, as a SecureString. Must satisfy the applicable password policy complexity rules.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resetToken
The single-use reset token issued by Connect-R1Session when the password has expired.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
