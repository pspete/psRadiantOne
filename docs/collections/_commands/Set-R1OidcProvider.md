---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1OidcProvider

## SYNOPSIS
Updates an OIDC provider configuration.

## SYNTAX

```
Set-R1OidcProvider [-configurationName] <String> [[-providerName] <String>] [[-discoveryUrl] <String>]
 [[-authorizationEndpointUri] <String>] [[-tokenEndpointUri] <String>] [[-clientId] <String>]
 [[-requestedScopes] <String[]>] [[-oidcToFidUserMappings] <String[]>] [[-clientSecret] <SecureString>]
 [[-enabled] <Boolean>] [[-clientAuthenticationMethod] <String>] [-useExistingCredentials] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates an existing OIDC provider configuration.

The resource is retrieved before it is updated, and sent back with the supplied values applied
over it, so a property left unspecified keeps its current value. The command therefore issues a
GET followed by a PUT, and the account needs permission to read the resource as well as to
change it.

The client secret cannot be carried forward, because the retrieval does not return it. Omit it to
leave the stored secret unchanged, or specify useExistingCredentials to be explicit about that.

This command updates one provider. The API also exposes a bulk form, PUT /oidc_providers, which
replaces the entire collection with the array supplied and so deletes any provider left out of
it. That form is deliberately not exposed by this module.

## EXAMPLES

### Example 1
```powershell
Set-R1OidcProvider -configurationName 'entra' -enabled $false
```

Disables the named provider, leaving everything else as it is.

### Example 2
```powershell
Set-R1OidcProvider -configurationName 'entra' -requestedScopes openid, profile, email -useExistingCredentials
```

Changes the requested scopes, keeping the stored client secret.

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

Required: False
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

Required: False
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

Required: False
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

Required: False
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

Required: False
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

Required: False
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

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useExistingCredentials
Keep the stored client secret. Any secret supplied in the request is ignored by the API when this is specified.

```yaml
Type: SwitchParameter
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

### System.String[]

### System.Boolean

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
