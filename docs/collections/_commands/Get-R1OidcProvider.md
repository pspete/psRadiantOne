---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1OidcProvider

## SYNOPSIS
Returns OIDC provider configurations.

## SYNTAX

### All (Default)
```
Get-R1OidcProvider [<CommonParameters>]
```

### ConfigurationName
```
Get-R1OidcProvider -configurationName <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the OIDC provider configurations. Specify a configuration name to return a single
provider; when none is given, every provider is returned.

## EXAMPLES

### Example 1
```powershell
Get-R1OidcProvider
```

Returns every OIDC provider configuration.

### Example 2
```powershell
Get-R1OidcProvider -configurationName 'entra'
```

Returns the named provider configuration.

## PARAMETERS

### -configurationName
The name identifying the OIDC provider configuration.

```yaml
Type: String
Parameter Sets: ConfigurationName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.OidcProvider

## NOTES

## RELATED LINKS
