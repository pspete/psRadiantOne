---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1AdapToken

## SYNOPSIS
Validates an ADAP bearer token.

## SYNTAX

```
Test-R1AdapToken [[-Token] <String>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Validates a bearer token and, where it is valid, extracts the target DN associated with it.

Returns true when the token passes validation and false when it is missing, malformed, or otherwise
does not validate. Specify PassThru to return the ADAP token information, including the target DN,
rather than a boolean.

When no token is specified, the token held in the current session is validated.

## EXAMPLES

### Example 1
```powershell
Test-R1AdapToken
```

Validates the token held in the current session.

### Example 2
```powershell
Test-R1AdapToken -Token $token -PassThru
```

Validates the specified token and returns its target DN.

## PARAMETERS

### -PassThru
Return the ADAP token information, including the target DN, instead of a boolean.

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

### -Token
The bearer token to validate. Defaults to the token held in the current session.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### System.Boolean

## NOTES

## RELATED LINKS
