---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextContentRdnAttribute

## SYNOPSIS
Returns the attributes available to the RDN of a content node.

## SYNTAX

```
Get-R1NamingContextContentRdnAttribute [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the attributes of the object behind a content or container node which can be used to build its RDN, each with the name it is mapped to.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextContentRdnAttribute -dn 'EMPLOYEES,o=DBJoin'
```

Returns the attributes available to the RDN of a content node at EMPLOYEES,o=DBJoin.

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

### psRadiantOne.ContentRdnAttribute

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
