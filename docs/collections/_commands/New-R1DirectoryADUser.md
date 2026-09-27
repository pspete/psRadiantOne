---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/New-R1DirectoryADUser
schema: 2.0.0
title: New-R1DirectoryADUser
category: Directory Browser
---

# New-R1DirectoryADUser

## SYNOPSIS
Adds an Active Directory user to the directory.

## SYNTAX

### Settings (Default)
```
New-R1DirectoryADUser -cn <String> -parentDn <String> -sAMAccountName <String> -sn <String>
 [-givenName <String>] [-password <SecureString>] [-changePasswordAtNextLogon <Boolean>]
 [-cannotChangePassword <Boolean>] [-passwordNeverExpires <Boolean>] [-accountDisabled <Boolean>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### UserAccountControl
```
New-R1DirectoryADUser -cn <String> -parentDn <String> -sAMAccountName <String> -sn <String>
 [-givenName <String>] [-password <SecureString>] [-changePasswordAtNextLogon <Boolean>]
 -userAccountControl <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a user entry beneath the parent DN given, with the attributes the control panel offers for an
Active Directory user.

The DN of the new entry is built from the cn and the parent DN, with the cn escaped as a DN requires.
The entry carries the object classes top, person, organizationalPerson and user.

The account settings are sent as the userAccountControl attribute. Either give the settings, which are
combined with NORMAL_ACCOUNT (512), or give the userAccountControl value itself.
Changing the password at next logon is sent as a pwdLastSet of 0, so is available with either.

## EXAMPLES

### Example 1
```powershell
$Password = Read-Host -AsSecureString
New-R1DirectoryADUser -cn jsmith -sAMAccountName jsmith -givenName Jane -sn Smith -password $Password -changePasswordAtNextLogon $true -parentDn 'ou=people,o=companydirectory'
```

Adds cn=jsmith,ou=people,o=companydirectory, a normal account whose password must be changed at next
logon.

### Example 2
```powershell
New-R1DirectoryADUser -cn svc-app -sAMAccountName svc-app -sn svc-app -parentDn 'ou=service,o=companydirectory' -passwordNeverExpires $true -cannotChangePassword $true
```

Adds an account whose password never expires and cannot be changed by the user, a userAccountControl
of 66112.

### Example 3
```powershell
New-R1DirectoryADUser -cn svc-app -sAMAccountName svc-app -sn svc-app -parentDn 'ou=service,o=companydirectory' -userAccountControl 66050
```

Adds a disabled account whose password never expires, from the userAccountControl value.

## PARAMETERS

### -cn
The common name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parentDn
The DN of the entry to add the user beneath.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sAMAccountName
The logon name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sn
The surname of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -givenName
The given name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
The password of the user, sent as the unicodePwd attribute.
Active Directory only accepts a password over an SSL connection to it.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -changePasswordAtNextLogon
Whether the user must change the password at next logon, sent as a pwdLastSet of 0.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cannotChangePassword
Whether the user cannot change the password, PASSWD_CANT_CHANGE (64).

```yaml
Type: Boolean
Parameter Sets: Settings
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordNeverExpires
Whether the password never expires, DONT_EXPIRE_PASSWORD (65536).

```yaml
Type: Boolean
Parameter Sets: Settings
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accountDisabled
Whether the account is disabled, ACCOUNTDISABLE (2).

```yaml
Type: Boolean
Parameter Sets: Settings
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userAccountControl
The userAccountControl value to send, in place of the settings.

```yaml
Type: Int32
Parameter Sets: UserAccountControl
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Void

## NOTES

## RELATED LINKS

[New-R1DirectoryEntry](New-R1DirectoryEntry)

[Reset-R1DirectoryEntryPassword](Reset-R1DirectoryEntryPassword)
