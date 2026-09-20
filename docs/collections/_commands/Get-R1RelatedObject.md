---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1RelatedObject

## SYNOPSIS
Returns the definitions of objects related to a primary object in the object builder.

## SYNTAX

```
Get-R1RelatedObject [-dn] <String> [-primaryObject] <String> [-objectDn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the definitions of the objects along a relationship path from a primary object, each with
its table and attributes, in the form the input sources of an object model hold them.

The path names the related tables from the primary object outwards, separated by commas. Adding
the definitions to the model and saving it with Set-R1SecondaryObject makes them part of the
model.

## EXAMPLES

### Example 1
```powershell
Get-R1RelatedObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -objectDn 'APP.ORDERS,APP.CUSTOMERS'
```

Returns the definitions of APP.ORDERS and APP.CUSTOMERS, related to each employee through their
orders.

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

### -objectDn
The relationship path to the related object, naming each table along it.

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

### psRadiantOne.RelatedObject

## NOTES

## RELATED LINKS

[Set-R1SecondaryObject](Set-R1SecondaryObject)

[Get-R1SecondaryObject](Get-R1SecondaryObject)
