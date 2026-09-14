---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1ComputedAttributeName

## SYNOPSIS
Reports whether a computed attribute name is valid.

## SYNTAX

```
Test-R1ComputedAttributeName [-computedAttributeName] <String> [<CommonParameters>]
```

## DESCRIPTION
Asks the server whether the given name may be used as a computed attribute name, and returns
whether it is valid.

## EXAMPLES

### Example 1
```powershell
Test-R1ComputedAttributeName -computedAttributeName 'fullName'
```

Returns true, the name being valid.

### Example 2
```powershell
Test-R1ComputedAttributeName -computedAttributeName 'full name' -Verbose
```

Returns false, and writes the reason the name was rejected to the verbose stream.

## PARAMETERS

### -computedAttributeName
The computed attribute name to validate.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean

## NOTES

Where the API reports why a value is invalid, the reason is written to the verbose stream.
Run with -Verbose to see it.

## RELATED LINKS

[Test-R1LdapFilter](Test-R1LdapFilter)

[Test-R1JoinCondition](Test-R1JoinCondition)
