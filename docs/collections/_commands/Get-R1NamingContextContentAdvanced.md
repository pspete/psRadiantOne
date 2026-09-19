---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextContentAdvanced

## SYNOPSIS
Returns the advanced settings of a content node.

## SYNTAX

```
Get-R1NamingContextContentAdvanced [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the advanced settings of a content or container node, including its interception script, the operations the script intercepts, its object class mapping, search case sensitivity, the SQL where clause or LDAP filter applied to its queries, and the number of attributes requested.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextContentAdvanced -dn 'EMPLOYEES,o=DBJoin'
```

Returns the advanced settings of a content node at EMPLOYEES,o=DBJoin.

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

### psRadiantOne.ContentAdvanced

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
