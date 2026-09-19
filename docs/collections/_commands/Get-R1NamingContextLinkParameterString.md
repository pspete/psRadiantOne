---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLinkParameterString

## SYNOPSIS
Returns the parameter string for a link parameter.

## SYNTAX

```
Get-R1NamingContextLinkParameterString [-dn] <String> [-linkParameterAttrName] <String> [-linkParameterAttrType] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the parameter string a link node uses to pass an attribute of the given name and type to the view it links to.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLinkParameterString -dn 'dv=address book,o=vds' -linkParameterAttrName 'CN' -linkParameterAttrType 'VARCHAR'
```

Returns the parameter string for a link parameter at dv=address book,o=vds.

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

### -linkParameterAttrName
The name of the attribute passed as the link parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -linkParameterAttrType
The type of the attribute passed as the link parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: attrType

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

### System.String

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
