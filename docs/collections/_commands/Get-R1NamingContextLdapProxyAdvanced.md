---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextLdapProxyAdvanced

## SYNOPSIS
Returns the advanced settings of an LDAP proxy node.

## SYNTAX

```
Get-R1NamingContextLdapProxyAdvanced [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the advanced settings of the LDAP proxy mounted at the naming context node, including its interception script, object class mapping, pre and post processing filters, the branches it includes and excludes, and how it handles each global attribute.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextLdapProxyAdvanced -dn 'o=companyprofiles'
```

Returns the advanced settings of an LDAP proxy node at o=companyprofiles.

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

### psRadiantOne.LdapProxyAdvanced

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
