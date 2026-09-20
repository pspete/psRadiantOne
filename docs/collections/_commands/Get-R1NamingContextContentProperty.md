---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextContentProperty

## SYNOPSIS
Returns the properties of a content node.

## SYNTAX

```
Get-R1NamingContextContentProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of the content or container node at the DN: the RDN name, the columns or attributes its RDN values are built from, its primary key, the schema it is based on, and whether it is a content or a container node.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextContentProperty -dn 'uid,ou=DBcontextview,o=sampleviews'
```

Returns the properties of a content node at uid,ou=DBcontextview,o=sampleviews.

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

### psRadiantOne.ContentProperties

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
