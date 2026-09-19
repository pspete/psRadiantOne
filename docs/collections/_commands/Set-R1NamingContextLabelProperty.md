---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextLabelProperty

## SYNOPSIS
Updates the properties of a label naming context node.

## SYNTAX

```
Set-R1NamingContextLabelProperty [-dn] <String> [[-rdnPrefix] <String>] [[-rdnSuffix] <String>]
 [[-objectClasses] <String[]>] [[-description] <String>] [[-virtualAttributes] <Object[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the RDN, object classes, description and virtual attributes of the label node identified
by its DN.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextLabelProperty -dn 'ou=people,o=views' -objectClasses 'top', 'extensibleObject'
```

Gives the label ou=people,o=views the extensibleObject object class as well as top.

### Example 2
```powershell
Set-R1NamingContextLabelProperty -dn 'ou=people,o=views' -description 'Everyone'
```

Sets the description of the label, leaving its other properties as they are.

## PARAMETERS

### -dn
The DN of the label node.

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

### -rdnPrefix
The attribute naming the label, for example ou.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -rdnSuffix
The value naming the label.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectClasses
The object classes of the label entry.

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

### -description
A description of the label. An empty string clears it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -virtualAttributes
The virtual attributes the label entry presents.

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

Changing rdnPrefix or rdnSuffix renames the label, so its DN changes.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1NamingContextLabelProperty](Get-R1NamingContextLabelProperty)

[New-R1NamingContextLabel](New-R1NamingContextLabel)
