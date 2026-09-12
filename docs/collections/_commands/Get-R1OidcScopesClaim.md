---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1OidcScopesClaim

## SYNOPSIS
Returns the scopes and claims an OIDC provider offers.

## SYNTAX

```
Get-R1OidcScopesClaim [-discoveryUrl] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the scopes and claims published by an OIDC provider discovery document, which are the
values available for requestedScopes and for claim mapping.

## EXAMPLES

### Example 1
```powershell
Get-R1OidcScopesClaim -discoveryUrl 'https://idp.example.com/.well-known/openid-configuration'
```

Returns the scopes and claims the provider offers.

## PARAMETERS

### -discoveryUrl
The OIDC discovery document URL of the provider.

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

## OUTPUTS

### psRadiantOne.OidcScopesClaims

## NOTES

## RELATED LINKS
