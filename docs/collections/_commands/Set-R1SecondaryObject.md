---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1SecondaryObject

## SYNOPSIS
Saves the object model built in the object builder for a primary object.

## SYNTAX

```
Set-R1SecondaryObject [-dn] <String> [-primaryObject] <String> [[-finalOutput] <Object>] [[-joins] <Object[]>]
 [[-attributeMappings] <Object[]>] [[-inputSources] <Object[]>] [[-joinComputedAttributes] <Object[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Saves the object model of a primary object in the object builder: its input sources, attribute
mappings, joins, join computed attributes and final output. This is what the SAVE button of the
object builder sends.

The current model is retrieved first and each section which is not specified is sent back
unchanged. The usual way to change a model is to retrieve it with Get-R1SecondaryObject, change
the section concerned and pass that section back.

## EXAMPLES

### Example 1
```powershell
$Model = Get-R1SecondaryObject -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson'
($Model.finalOutput.attributes | Where-Object virtualName -EQ 'NOTES').isHidden = $true
$Model | Set-R1SecondaryObject -dn 'uid,ou=hr,o=views' -primaryObject 'inetorgperson'
```

Hides the NOTES attribute from the entries of the node, piping the whole model back.

### Example 2
```powershell
$Model = Get-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
$Related = Get-R1RelatedObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -objectDn 'APP.ORDERS,APP.CUSTOMERS'
$Primary = $Model.inputSources | Where-Object sourceType -EQ 'PRIMARY'
$Primary.relatedObjects = @($Primary.relatedObjects) + @($Related)
Set-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -inputSources $Model.inputSources
```

Adds the orders and customers related to each employee to the input sources of the model.

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

### -finalOutput
The attributes the entries present, with their origin and precedence, and the bind order.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -joins
The joins to secondary objects.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attributeMappings
The attributes of the input sources and the names they are presented with.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -inputSources
The primary object and the other objects the model draws on, each with its related objects.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -joinComputedAttributes
The computed attributes used in joins.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Void

## NOTES

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1SecondaryObject](Get-R1SecondaryObject)

[Get-R1PrimaryObject](Get-R1PrimaryObject)

[Get-R1RelatedObject](Get-R1RelatedObject)
