---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1ComputedAttributeExpression

## SYNOPSIS
Builds a computed attribute expression from a function.

## SYNTAX

### Value (Default)
```
New-R1ComputedAttributeExpression [-dn] <String> [-primaryObject] <String> [-signature] <String>
 [-value <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Values
```
New-R1ComputedAttributeExpression [-dn] <String> [-primaryObject] <String> [-signature] <String>
 [-values] <IDictionary> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds the expression calling one of the functions available to computed attributes, with the
values given for its parameters. Get-R1ComputedAttributeFunction lists the functions and their
signatures.

Nothing is saved on the server: the expression is returned for use in a computed attribute.

The server substitutes the values positionally. Pass them with -value in the order the signature
lists them and each is named from the function's own parameter list. -values takes them keyed by
parameter name instead, and has to be an ordered dictionary: a plain hashtable enumerates in no
particular order and the values are substituted in whatever order that turns out to be.

## EXAMPLES

### Example 1
```powershell
New-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -signature 'upper(attribute)' -values @{ attribute = 'FIRSTNAME' }
```

Returns upper(FIRSTNAME).

### Example 2
```powershell
New-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -signature 'replaceNull(attribute, defaultValue)' -value 'FIRSTNAME', 'unknown'
```

Returns replaceNull(FIRSTNAME,unknown), naming each value from the parameters of the function.

### Example 3
```powershell
New-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -signature 'randomUUID()'
```

Returns randomUUID(), a function which takes no values.

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

### -signature
The signature of the function, as Get-R1ComputedAttributeFunction returns it.

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

### -value
The value of each parameter of the function, in the order the signature lists them. The function is
looked up to name them, so the signature must be one Get-R1ComputedAttributeFunction returns.

```yaml
Type: String[]
Parameter Sets: Value
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -values
The value of each parameter of the function, keyed by the parameter name. Pass an ordered
dictionary: the values are substituted in the order the dictionary enumerates them.

```yaml
Type: IDictionary
Parameter Sets: Values
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Get-R1ComputedAttributeFunction](Get-R1ComputedAttributeFunction)

[Test-R1ComputedAttributeExpression](Test-R1ComputedAttributeExpression)

[Convert-R1ComputedAttributeExpression](Convert-R1ComputedAttributeExpression)
