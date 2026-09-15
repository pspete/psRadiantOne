---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1DirectoryAuthentication

## SYNOPSIS
Reports whether a DN and password authenticate.

## SYNTAX

```
Test-R1DirectoryAuthentication [-dn] <String> [-password] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Asks the server to bind as the given DN with the given password and returns whether it succeeded.
The DN may also be a username the deployment maps internally.

The request body is sent as UTF8 bytes so that the password cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Test-R1DirectoryAuthentication -dn 'uid=one,o=example' -password $Secret
```

Returns true when the credentials authenticate.

## PARAMETERS

### -dn
The DN of the entry.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
The password.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS

[Reset-R1DirectoryEntryPassword](Reset-R1DirectoryEntryPassword)
