---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1ComputedAttributeExpression

## SYNOPSIS
Tests whether a computed attribute expression compiles.

## SYNTAX

```
Test-R1ComputedAttributeExpression [-dn] <String> [-primaryObject] <String> -name <String>
 [-expression] <String> [[-attributes] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Compiles a computed attribute, its name and expression together, against the attributes of the object
model and returns whether it is valid. When it is not, the reason is written to the verbose stream.

## EXAMPLES

### Example 1
```powershell
Test-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -name 'displayName' -expression 'upper(FIRSTNAME)+" "+LASTNAME'
```

Returns true when the expression compiles.

### Example 2
```powershell
$Model = Get-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
$Attributes = ($Model.inputSources | Where-Object sourceType -NE 'PRIMARY').attributes.name
Test-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -name 'displayName' -expression 'upper(FIRSTNAME)+" "+LastName' -attributes $Attributes -Verbose
```

Tests the expression against the attributes of the other input sources of the model, writing the reason it fails, here
that LastName is not a known symbol, to the verbose stream.

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

### -expression
The expression, without the attribute name.

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

### -attributes
The attributes of the other input sources of the model which the expression may use. The
attributes of the primary object need not be given.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the computed attribute.

```yaml
Type: String
Parameter Sets: (All)
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

### None

## OUTPUTS

### System.Boolean

## NOTES

## RELATED LINKS

[New-R1ComputedAttributeExpression](New-R1ComputedAttributeExpression)

[Convert-R1ComputedAttributeExpression](Convert-R1ComputedAttributeExpression)
