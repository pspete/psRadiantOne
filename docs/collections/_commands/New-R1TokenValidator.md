---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1TokenValidator

## SYNOPSIS
Creates an external token validator.

## SYNTAX

```
New-R1TokenValidator [-name] <String> [-jsonWebKeySetUri] <String> [[-enabled] <Boolean>]
 [[-apiService] <String>] [[-oidcProvider] <String>] [[-oidcDiscoveryUrl] <String>]
 [[-scopeClaimName] <String>] [[-expectedAudience] <String>] [[-expectedScope] <String>]
 [[-jwtValidationClock] <Int32>] [[-claimsExpressionList] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an external token validator, which accepts tokens issued by an external OIDC provider
for either the ADAP REST API or SCIM.

The API defines two variants discriminated by apiService, but they carry identical properties,
so one command covers both.

## EXAMPLES

### Example 1
```powershell
New-R1TokenValidator -name 'partner-idp' -apiService SCIM -jsonWebKeySetUri 'https://idp.example.com/jwks'
```

Creates a SCIM token validator using the specified key set.

### Example 2
```powershell
New-R1TokenValidator -name 'adap-idp' -apiService 'REST(adap)' -jsonWebKeySetUri 'https://idp.example.com/jwks' -expectedAudience radiantone -claimsExpressionList 'uid=$sub'
```

Creates an ADAP token validator with an expected audience and a claims mapping expression.

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

### -apiService
The API the validator applies to. REST(adap) or SCIM.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: REST(adap), SCIM

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -claimsExpressionList
The claims mapping expressions. The API nests these in a claimsMapper object, which this command builds, so the expressions are given directly.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enabled
Whether the validator is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expectedAudience
The audience a token must carry to be accepted.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expectedScope
The scope a token must carry to be accepted.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jsonWebKeySetUri
The JSON web key set URI used to verify token signatures.

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

### -jwtValidationClock
Clock skew allowed when validating a token, in seconds, up to 3600.

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

### -name
The name of the external token validator.

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

### -oidcDiscoveryUrl
The OIDC discovery document URL of the provider.

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

### -oidcProvider
The OIDC provider the tokens come from. Apple, Google, Microsoft, Salesforce, Yahoo or Custom. Values other than Custom are retained for legacy reasons and are converted to Custom by the API.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Apple, Google, Microsoft, Salesforce, Yahoo, Custom

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scopeClaimName
The name of the claim holding the token scopes.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Boolean

### System.Int32

### System.String[]

## OUTPUTS

### System.Void

## NOTES

The API rejects a create which carries only some of the validator's properties, answering "Cannot
convert request body to required type" and creating nothing. The control panel sends every one of
-name, -enabled, -oidcProvider, -oidcDiscoveryUrl, -jsonWebKeySetUri, -jwtValidationClock,
-scopeClaimName, -expectedAudience, -apiService, -expectedScope and -claimsExpressionList.

Which of them the API insists on has not been established.

## RELATED LINKS
