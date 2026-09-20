---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLdapProxyBackend

## SYNOPSIS
Returns the backend of an LDAP proxy node.

## SYNTAX

```
Get-R1NamingContextLdapProxyBackend [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the backend the LDAP proxy mounted at the naming context node sends its requests to: the data source and base DN, how connections and authorization are handled, and the schema enforcement mode.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLdapProxyBackend -dn 'o=companyprofiles'
```

Returns the backend of an LDAP proxy node at o=companyprofiles.

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

### psRadiantOne.LdapProxyBackend

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
