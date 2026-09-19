---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1JoinCondition

## SYNOPSIS
Reports whether a join condition is valid.

## SYNTAX

```
Test-R1JoinCondition [-joinCondition] <String> [<CommonParameters>]
```

## DESCRIPTION
Asks the server to parse the given join condition, and returns whether it is valid.

## EXAMPLES

### Example 1
```powershell
Test-R1JoinCondition -joinCondition '(uid=@[UID])'
```

Returns true, the join condition being valid.

## PARAMETERS

### -joinCondition
The join condition to validate.

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

This endpoint reports validity only, without a reason when a condition is rejected.

## RELATED LINKS

[Get-R1JoinCondition](Get-R1JoinCondition)

[Test-R1LdapFilter](Test-R1LdapFilter)
