---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextMergedBackend

## SYNOPSIS
Returns the backends merged into an LDAP proxy node.

## SYNTAX

```
Get-R1NamingContextMergedBackend [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the backends merged into the LDAP proxy mounted at the naming context node. Nothing is returned for a proxy with no merged backends.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextMergedBackend -dn 'o=proxy'
```

Returns the backends merged into an LDAP proxy node at o=proxy, each with its data source, remote
base DN and the DN it is presented at.

### Example 2
```powershell
Get-R1NamingContextMergedBackend -dn 'o=proxy' | Where-Object dataSource -EQ 'vds' | Remove-R1NamingContextMergedBackend -dn 'o=proxy'
```

Removes the backends merged from the vds data source, prompting for confirmation of each.

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

### psRadiantOne.MergedBackend

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
