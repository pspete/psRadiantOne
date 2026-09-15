---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1JoinCondition

## SYNOPSIS
Builds a join condition from the given join properties.

## SYNTAX

```
Get-R1JoinCondition [-secondaryObject] <String> [-primaryJoinAttribute] <String>
 [-secondaryJoinAttribute] <String> [<CommonParameters>]
```

## DESCRIPTION
Asks the server to construct a join condition string from a secondary object and the pair of
attributes being joined on, and returns the condition it produced. Nothing is saved.

## EXAMPLES

### Example 1
```powershell
Get-R1JoinCondition -secondaryObject 'inetOrgPerson' -primaryJoinAttribute 'EMPLOYEEID' -secondaryJoinAttribute 'employeeID'
```

Returns the join condition built from those properties.

### Example 2
```powershell
(Get-R1JoinCondition -secondaryObject 'inetOrgPerson' -primaryJoinAttribute 'EMPLOYEEID' -secondaryJoinAttribute 'employeeID').joinCondition | Test-R1JoinCondition
```

Builds a join condition and checks that the server accepts it.

## PARAMETERS

### -secondaryObject
The secondary object of the join.

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

### -primaryJoinAttribute
The attribute of the primary object to join on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondaryJoinAttribute
The attribute of the secondary object to join on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.JoinConditionObject

## NOTES

## RELATED LINKS

[Test-R1JoinCondition](Test-R1JoinCondition)
