---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1OidcProvider

## SYNOPSIS
Creates an OIDC provider configuration.

## SYNTAX

```
New-R1OidcProvider [-configurationName] <String> [-providerName] <String> [-discoveryUrl] <String>
 [-authorizationEndpointUri] <String> [-tokenEndpointUri] <String> [-clientId] <String>
 [-requestedScopes] <String[]> [-oidcToFidUserMappings] <String[]> [[-clientSecret] <SecureString>]
 [[-enabled] <Boolean>] [[-clientAuthenticationMethod] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an OIDC provider configuration, allowing users to authenticate to the control panel
through an external identity provider.

Get-R1OidcDiscoveryInfo returns the endpoints published by a provider discovery document, and
Get-R1OidcScopesClaim the scopes and claims it offers.

The request body is sent as UTF8 bytes so that the plaintext client secret cannot be captured by
Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
New-R1OidcProvider -configurationName 'entra' -providerName Custom -discoveryUrl $discovery -authorizationEndpointUri $auth -tokenEndpointUri $token -clientId 'abc123' -clientSecret $secret -requestedScopes openid, profile -oidcToFidUserMappings 'uid=$sub'
```

Creates a provider configuration mapping the OIDC subject claim to a FID uid.

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

### -authorizationEndpointUri
The provider authorization endpoint.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientAuthenticationMethod
How the client authenticates to the token endpoint. CLIENT_SECRET_POST or CLIENT_SECRET_BASIC.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: CLIENT_SECRET_POST, CLIENT_SECRET_BASIC

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientId
The OAuth client id registered with the provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientSecret
The OAuth client secret, as a SecureString. When omitted on update, the stored secret is left unchanged.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -configurationName
The name identifying the OIDC provider configuration.

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

### -discoveryUrl
The OIDC discovery document URL of the provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enabled
Whether the provider is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -oidcToFidUserMappings
Expressions mapping OIDC claims to FID users.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -providerName
The provider. Apple, Google, Microsoft, Salesforce, Yahoo or Custom. Values other than Custom are retained for legacy reasons and are converted to Custom by the API.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Apple, Google, Microsoft, Salesforce, Yahoo, Custom

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requestedScopes
The scopes requested from the provider. Get-R1OidcScopesClaim returns those a provider offers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tokenEndpointUri
The provider token endpoint.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.String[]

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
