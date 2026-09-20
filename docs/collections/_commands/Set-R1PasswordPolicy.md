---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1PasswordPolicy

## SYNOPSIS
Updates a password policy.

## SYNTAX

```
Set-R1PasswordPolicy [-policyName] <String> [[-targetType] <String>] [[-targetDn] <String>]
 [[-precedence] <Int32>] [[-passwordMustChangeAfterReset] <Boolean>] [[-userMayChangePassword] <Boolean>]
 [[-requireExistingPasswordToChange] <Boolean>] [[-allowChangesInterval] <Int32>]
 [[-passwordKeepHistory] <Boolean>] [[-passwordHistorySize] <Int32>] [[-passwordExpires] <Boolean>]
 [[-passwordExpiresAfterInterval] <Int32>] [[-warningBeforeExpirationInterval] <Int32>]
 [[-graceLoginAttemptAfterExpiration] <Int32>] [[-contentEnabled] <Boolean>] [[-passwordMinLength] <Int32>]
 [[-passwordLeastNumChars] <Int32>] [[-passwordLeastLowerChars] <Int32>] [[-passwordLeastUpperChars] <Int32>]
 [[-passwordLeastSpecialChars] <Int32>] [[-pwdQualityMinChangedChar] <Int32>]
 [[-pwdEnableNotContainNames] <Boolean>] [[-passwordEncryptionAlgorithm] <String>]
 [[-pwdEnableAlgorithmUpgrade] <Boolean>] [[-pwdPattern] <String>]
 [[-enablePwdPolicyDictionarySubstringCheck] <Boolean>] [[-pwdEnableDictionary] <Boolean>]
 [[-passwordLockout] <Boolean>] [[-passwordLoginFailureCountBeforeLockout] <Int32>]
 [[-passwordResetFailureCountAfterMinutes] <Int32>] [[-passwordLockoutDuration] <Int32>]
 [[-pwdEnableLastLogonTime] <Boolean>] [[-passwordLastLogonTime] <Int32>]
 [[-passwordIdleLockoutInterval] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the settings of a password policy, or creates one which does not exist.

The resource is retrieved before it is updated, and sent back with the supplied values applied
over it, so a property left unspecified keeps its current value. The command therefore issues a
GET followed by a PUT, and the account needs permission to read the resource as well as to
change it.

A policy which does not yet exist is created, starting from the empty policy the API supplies, so
a property left unspecified takes the API default rather than a current value.

Note that passwordMustChangeAfterReset and userMayChangePassword together drive the expired
password flow: the first causes a login after an administrative reset to report the password as
expired, and the second determines whether a reset token is issued for it.

## EXAMPLES

### Example 1
```powershell
Set-R1PasswordPolicy -policyName 'Default' -passwordMinLength 14
```

Raises the minimum password length, leaving every other setting as it is.

### Example 2
```powershell
Set-R1PasswordPolicy -policyName 'Default' -passwordLockout $true -passwordLoginFailureCountBeforeLockout 5 -passwordLockoutDuration 900
```

Locks an account for fifteen minutes after five consecutive login failures.

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

### -allowChangesInterval
The minimum interval between password changes, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -contentEnabled
Whether the password content rules are enforced.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enablePwdPolicyDictionarySubstringCheck
Whether dictionary matching also rejects substrings.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -graceLoginAttemptAfterExpiration
How many logins are permitted after a password expires.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordEncryptionAlgorithm
The algorithm passwords are hashed with. Get-R1PasswordEncryption returns the available algorithms.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordExpires
Whether passwords expire.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordExpiresAfterInterval
How long a password remains valid, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordHistorySize
How many previous passwords are retained.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordIdleLockoutInterval
How long an account may be idle before it is locked, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordKeepHistory
Whether previous passwords are retained to prevent reuse.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLastLogonTime
The interval at which the last logon time is written, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLeastLowerChars
The minimum number of lower case characters.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLeastNumChars
The minimum number of numeric characters.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLeastSpecialChars
The minimum number of special characters.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLeastUpperChars
The minimum number of upper case characters.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLockout
Whether repeated login failures lock the account.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLockoutDuration
How long an account stays locked, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordLoginFailureCountBeforeLockout
How many consecutive failures trigger a lockout.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordMinLength
The minimum password length.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordMustChangeAfterReset
Whether a user must change their password on the first login after an administrative reset.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordResetFailureCountAfterMinutes
How long before the failure count resets, in minutes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -policyName
The name of the password policy. Required by the API as a query parameter on retrieval, update and deletion.

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

### -precedence
The precedence of the policy where more than one applies, 1 to 1000.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdEnableAlgorithmUpgrade
Whether stored passwords are rehashed with the current algorithm on next use.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdEnableDictionary
Whether passwords are checked against the dictionary.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdEnableLastLogonTime
Whether the last logon time is recorded.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdEnableNotContainNames
Whether a password may not contain the user name.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdPattern
A regular expression a password must match. Test-R1PasswordStrengthRule validates one before it is applied.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pwdQualityMinChangedChar
The minimum number of characters that must differ from the previous password.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requireExistingPasswordToChange
Whether changing a password requires the current one.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetDn
The DN of the group or subtree the policy applies to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetType
What the policy applies to. GROUP or SUBTREE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: GROUP, SUBTREE

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userMayChangePassword
Whether a user may change their own password. When false, no reset token is issued for an expired password.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -warningBeforeExpirationInterval
How long before expiry the user is warned, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Int32

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

The default policy is the one with an empty name, so a policy created here is always named.

## RELATED LINKS
