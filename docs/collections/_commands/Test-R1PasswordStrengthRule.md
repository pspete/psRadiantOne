---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1PasswordStrengthRule

## SYNOPSIS
Reports whether a password strength rule is valid.

## SYNTAX

```
Test-R1PasswordStrengthRule [-pattern] <String> [<CommonParameters>]
```

## DESCRIPTION
Validates a regular expression intended for use as the pwdPattern of a password policy, and
reports whether the API accepts it, without applying it.

The API returns no content for a valid pattern and an error describing the problem for an invalid
one, so the result is reported as a boolean. Use -Verbose to see why a pattern was rejected.

## EXAMPLES

### Example 1
```powershell
Test-R1PasswordStrengthRule -pattern '^(?=.*[A-Z])(?=.*\d).{10,}$'
```

Reports whether the pattern is a valid strength rule.

## PARAMETERS

### -pattern
The regular expression to validate as a password strength rule.

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

### System.Boolean

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
