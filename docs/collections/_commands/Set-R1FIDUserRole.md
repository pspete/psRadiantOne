---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1FIDUserRole

## SYNOPSIS
Sets the roles associated with a FID user.

## SYNTAX

```
Set-R1FIDUserRole [-username] <String> [-roles] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the complete list of roles associated with a FID user. Any role not included in the
supplied list is removed from the user.

The roles property is read-only on both the user and access token objects, so this command is the
only way to change the roles associated with a user. It targets an endpoint the API marks as
deprecated, but the RadiantOne 8.5.0 API offers no replacement for it.

## EXAMPLES

### Example 1
```powershell
Set-R1FIDUserRole -username john_smith -roles admin, dev
```

Associates the user with the admin and dev roles.

### Example 2
```powershell
Set-R1FIDUserRole -username john_smith -roles @()
```

Removes every role from the user.

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

### -roles
The complete list of role names to associate with the user. Any role not included is removed from the user.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -username
The username of the user whose roles are being set.

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

### System.String[]

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
