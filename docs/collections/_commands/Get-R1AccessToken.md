---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AccessToken

## SYNOPSIS
Returns RadiantOne access tokens.

## SYNTAX

### All (Default)
```
Get-R1AccessToken [<CommonParameters>]
```

### Name
```
Get-R1AccessToken -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the access tokens configured on the RadiantOne deployment.

Specify a name to return a single access token; when no name is specified, all access tokens are
returned. The token value itself is never returned - it can only be viewed once, at the point the
token is created by New-R1AccessToken.

## EXAMPLES

### Example 1
```powershell
Get-R1AccessToken
```

Returns all access tokens.

### Example 2
```powershell
Get-R1AccessToken -name 'Prod Service Account'
```

Returns the named access token.

## PARAMETERS

### -name
The name of the access token to return. When omitted, all access tokens are returned.

```yaml
Type: String
Parameter Sets: Name
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

### psRadiantOne.AccessToken

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
