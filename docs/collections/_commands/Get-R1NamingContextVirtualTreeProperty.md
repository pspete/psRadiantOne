---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextVirtualTreeProperty

## SYNOPSIS
Returns the virtual tree properties of a naming context.

## SYNTAX

```
Get-R1NamingContextVirtualTreeProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of the virtual tree mounted at the naming context node, including the
directory view it presents, its backing data source and its virtual attribute mappings.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextVirtualTreeProperty -dn 'o=vds'
```

Returns the virtual tree properties of o=vds.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.VirtualTreeProperties

## NOTES

## RELATED LINKS

[Set-R1NamingContextVirtualTreeProperty](Set-R1NamingContextVirtualTreeProperty)

[Get-R1NamingContext](Get-R1NamingContext)
