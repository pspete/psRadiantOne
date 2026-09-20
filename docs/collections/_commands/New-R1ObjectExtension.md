---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1ObjectExtension

## SYNOPSIS
Builds the definition of an object extension for the object builder.

## SYNTAX

```
New-R1ObjectExtension [-dn] <String> [-primaryObject] <String> [-attributes] <String[]>
 [[-objectClass] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds the definition of an object class extension for the object model of a primary object,
adding attributes which none of its sources provide.

Nothing is saved on the server. The definition is returned so that it can be added to the object
model and saved with Set-R1SecondaryObject, as the SAVE button of the object builder does.

## EXAMPLES

### Example 1
```powershell
$Source = New-R1ObjectExtension -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -attributes 'capNote'
$Model = Get-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
$Model.inputSources = @($Model.inputSources) + $Source
$Model | Set-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
```

Adds the attribute capNote to the model through the extensibleobject object class.

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

### -attributes
The attributes the extension adds.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectClass
The object class of the extension. Defaults to extensibleobject.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Extensibleobject
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

### psRadiantOne.InputSource

## NOTES

## RELATED LINKS

[New-R1ObjectInputSource](New-R1ObjectInputSource)

[Set-R1SecondaryObject](Set-R1SecondaryObject)
