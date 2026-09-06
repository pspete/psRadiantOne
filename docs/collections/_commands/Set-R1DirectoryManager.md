---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DirectoryManager

## SYNOPSIS
Updates the directory manager settings.

## SYNTAX

```
Set-R1DirectoryManager [-userName] <String> [-password] <SecureString> [[-oldPassword] <SecureString>]
 [[-allowedIps] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the directory manager settings, including the directory manager password and the list of IP
addresses permitted to bind as the directory manager.

The request body is sent as UTF8 bytes so that the plaintext password cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Set-R1DirectoryManager -userName 'cn=Directory Manager' -password $newSecurePassword -oldPassword $currentSecurePassword
```

Changes the directory manager password.

### Example 2
```powershell
Set-R1DirectoryManager -userName 'cn=Directory Manager' -password $securePassword -allowedIps '10.0.0.1', '10.0.0.2'
```

Restricts directory manager binds to the specified IP addresses.

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

### -allowedIps
The list of IP addresses permitted to bind as the directory manager.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -oldPassword
The existing directory manager password, as a SecureString.

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

### -password
The new directory manager password, as a SecureString.

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

### -userName
The username of the directory manager, e.g. cn=Directory Manager

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

## RELATED LINKS
