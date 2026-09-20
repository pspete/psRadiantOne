---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextDbProxyProperty

## SYNOPSIS
Returns the properties of a database proxy node.

## SYNTAX

```
Get-R1NamingContextDbProxyProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of the database proxy mounted at the naming context node: the base DN it is mapped to, the directory view it presents, the data source behind it and whether it is active.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextDbProxyProperty -dn 'o=hrdatabase'
```

Returns the properties of a database proxy node at o=hrdatabase.

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

### psRadiantOne.DbProxyProperties

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
