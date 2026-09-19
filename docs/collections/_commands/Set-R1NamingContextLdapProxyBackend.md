---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextLdapProxyBackend

## SYNOPSIS
Updates the backend properties of an LDAP proxy naming context.

## SYNTAX

```
Set-R1NamingContextLdapProxyBackend [-dn] <String> [[-datasource] <String>] [[-baseDn] <String>]
 [[-schemaEnforcementMode] <String>] [[-isActive] <Boolean>] [[-isDedicatedConnection] <Boolean>]
 [[-isPassThroughAuthorization] <Boolean>] [[-isProxyAuthorization] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the connection properties of the LDAP proxy backend mounted at the naming context node.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextLdapProxyBackend -dn 'o=proxy' -isDedicatedConnection $true
```

Gives the LDAP proxy at o=proxy a dedicated connection, leaving its other properties as they are.

### Example 2
```powershell
Set-R1NamingContextLdapProxyBackend -dn 'o=proxy' -schemaEnforcementMode 'FILTER'
```

Filters the attributes returned through o=proxy against the schema.

## PARAMETERS

### -dn
The DN of the LDAP proxy naming context node.

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

### -datasource
The name of the LDAP data source proxied.

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

### -baseDn
The DN in the LDAP data source whose entries are presented.

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

### -schemaEnforcementMode
How the schema is enforced on the proxied entries: PASS_THROUGH, FILTER or STRICT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isActive
Whether the backend is active.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isDedicatedConnection
Whether the backend uses a connection of its own rather than a shared one.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isPassThroughAuthorization
Whether the identity of the client is passed through to the backend for authorization.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isProxyAuthorization
Whether the backend is asked to authorize requests using the proxied authorization control.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
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

The namespace DN is maintained by the server and cannot be changed here. It is sent back unaltered
so that the update carries the complete resource.

## RELATED LINKS

[Get-R1NamingContextLdapProxyBackend](Get-R1NamingContextLdapProxyBackend)

[Set-R1NamingContextLdapProxyAdvanced](Set-R1NamingContextLdapProxyAdvanced)

[Mount-R1NamingContextBackend](Mount-R1NamingContextBackend)
