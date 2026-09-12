---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1TokenValidator

## SYNOPSIS
Updates an external token validator.

## SYNTAX

```
Set-R1TokenValidator [-name] <String> [[-jsonWebKeySetUri] <String>] [[-enabled] <Boolean>]
 [[-apiService] <String>] [[-oidcProvider] <String>] [[-oidcDiscoveryUrl] <String>]
 [[-scopeClaimName] <String>] [[-expectedAudience] <String>] [[-expectedScope] <String>]
 [[-jwtValidationClock] <Int32>] [[-claimsExpressionList] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing external token validator.

The validator is retrieved before it is updated, and sent back with the supplied values applied
over it, so a property left unspecified keeps its current value. The command therefore issues a
GET followed by a PUT, and the account needs permission to read the validator as well as to
change it.

This command has not been exercised against a live deployment. No external token validator was configured on the deployment available, and one could not be created there, so its behaviour rests on the published API schema alone.

## EXAMPLES

### Example 1
```powershell
Set-R1TokenValidator -name 'partner-idp' -enabled $false
```

Disables the named validator, leaving everything else as it is.

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

Required: False
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

## RELATED LINKS
