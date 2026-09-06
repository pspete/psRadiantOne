---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Connect-R1Session

## SYNOPSIS
Authenticates to a RadiantOne deployment and establishes a session.

## SYNTAX

```
Connect-R1Session [-BaseURI] <String> [-Credential] <PSCredential> [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Authenticates against the RadiantOne v2 login endpoint and stores the returned authentication
token, together with the claims it carries, in the module scope session. Every other command in the
module uses that session, so this command must be run first.

If the bind fails specifically because the user's password has expired, the API reports a successful
request carrying password reset information rather than a token. In that case this command writes a
warning and returns the reset information, whose resetToken can be passed to Reset-R1Password to set
a new password. No session is established until the reset is completed and the user authenticates
again.

All other authentication failures - bad credentials, a locked account, a denied IP - throw a
terminating error.

## EXAMPLES

### Example 1
```powershell
$cred = Get-Credential
Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $cred
```

Authenticates as the supplied user and establishes the session used by all other commands.

### Example 2
```powershell
$reset = Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $cred
Reset-R1Password -resetToken $reset.resetToken -newPassword (Read-Host -AsSecureString)
```

Handles an expired password: the connect attempt returns the reset information, whose resetToken drives the password reset.

### Example 3
```powershell
Connect-R1Session -BaseURI 'https://radiantone.lab.local' -Credential $cred -SkipCertificateCheck
```

Connects to a deployment presenting a self-signed certificate.

## PARAMETERS

### -BaseURI
The base URL of the RadiantOne deployment to connect to, e.g. https://radiantone.company.com

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

### -Credential
A PSCredential object containing the username and password of the RadiantOne user to authenticate as.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipCertificateCheck
Bypass certificate validation for the request. Specify when the deployment presents a self-signed certificate.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Management.Automation.PSCredential

## OUTPUTS

### psRadiantOne.PasswordResetInfo

## NOTES

## RELATED LINKS
