---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Convert-R1ComputedAttributeExpression

## SYNOPSIS
Rewrites computed attribute expressions for a renamed attribute.

## SYNTAX

```
Convert-R1ComputedAttributeExpression [-dn] <String> [-primaryObject] <String> [-previousAttrName] <String>
 [-newAttrName] <String> [-expressions] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Rewrites computed attribute expressions so that they refer to an attribute by a new name, and returns
them. The object builder does this when an attribute used in an expression is renamed.

Nothing is saved on the server: the rewritten expressions are returned for the model to be saved
with them.

## EXAMPLES

### Example 1
```powershell
Convert-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -previousAttrName 'EMPLOYEEID' -newAttrName 'EMPLOYEEID1' -expressions 'upper(FIRSTNAME)+" "+EMPLOYEEID'
```

Returns upper(FIRSTNAME)+" "+EMPLOYEEID1.

## PARAMETERS

### -dn
The DN of the naming context node.

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

### -primaryObject
The name of the primary object, as Get-R1PrimaryObject returns it.

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

### -previousAttrName
The name the attribute had.

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

### -newAttrName
The name the attribute has now.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expressions
The expressions to rewrite.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Test-R1ComputedAttributeExpression](Test-R1ComputedAttributeExpression)

[Set-R1SecondaryObject](Set-R1SecondaryObject)
