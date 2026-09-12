---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1FIDUser

## SYNOPSIS
Updates a FID user.

## SYNTAX

```
Set-R1FIDUser [-username] <String> [[-active] <Boolean>] [[-password] <SecureString>] [[-firstName] <String>]
 [[-lastName] <String>] [[-email] <String>] [-roles <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing FID user.

The user is retrieved before it is updated, and the complete object is sent back with the supplied
values applied over it. This is what the control panel does, and it means a property left
unspecified keeps its current value rather than depending on the endpoint to merge a partial object.
One consequence is that the command issues two requests: a GET followed by a PUT.

Omit the password parameter to leave the user's existing password unchanged.

Roles may be supplied here. The API schema marks roles read-only, but the control panel sends them
on update and the API accepts them. Set-R1FIDUserRole remains available for changing only the roles.

## EXAMPLES

### Example 1
```powershell
Set-R1FIDUser -username john_smith -active $false
```

Disables the named user.

### Example 2
```powershell
Set-R1FIDUser -username john_smith -active $true -password $newSecurePassword
```

Sets a new password for the user.

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

### -active
Whether the user account is enabled.

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

### -email
The email address of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -firstName
The first name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastName
The last name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
A new password for the user, as a SecureString. When omitted, the existing password is left unchanged.

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

### -username
The username of the user to update.

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

### -roles
The complete list of role names the user should hold. Any role not included is removed from the
user. When not specified, the roles the user already holds are preserved.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
