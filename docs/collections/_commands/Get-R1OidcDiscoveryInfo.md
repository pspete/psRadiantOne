---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1OidcDiscoveryInfo

## SYNOPSIS
Returns the endpoints published by an OIDC discovery document.

## SYNTAX

```
Get-R1OidcDiscoveryInfo [-discoveryUrl] <String> [<CommonParameters>]
```

## DESCRIPTION
Reads an OIDC discovery document and returns the endpoints it publishes, which supply the
authorization and token endpoint values needed to create a provider configuration.

## EXAMPLES

### Example 1
```powershell
Get-R1OidcDiscoveryInfo -discoveryUrl 'https://idp.example.com/.well-known/openid-configuration'
```

Returns the endpoints published by the provider.

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

### psRadiantOne.OidcDiscoveryInfo

## NOTES

## RELATED LINKS
