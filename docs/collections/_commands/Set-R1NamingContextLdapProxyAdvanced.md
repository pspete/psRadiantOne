---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextLdapProxyAdvanced

## SYNOPSIS
Updates the advanced properties of an LDAP proxy naming context.

## SYNTAX

```
Set-R1NamingContextLdapProxyAdvanced [-dn] <String> [[-joinOptimized] <Boolean>]
 [[-limitedAttributesRequested] <Boolean>] [[-useClientSizeLimit] <Boolean>] [[-preProcessingFilter] <String>]
 [[-postProcessingFilter] <String>] [[-globalAttributesHandling] <Object[]>]
 [[-suffixBranchInclusion] <String[]>] [[-suffixBranchExclusion] <String[]>] [[-objectClassMapping] <Object[]>]
 [[-interceptOn] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the advanced properties of the LDAP proxy backend mounted at the naming context node,
such as its search filters, attribute handling and the operations its interception script handles.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextLdapProxyAdvanced -dn 'o=proxy' -useClientSizeLimit $true
```

Applies the size limit requested by the client to searches of o=proxy.

### Example 2
```powershell
Set-R1NamingContextLdapProxyAdvanced -dn 'o=proxy' -interceptOn 'BIND', 'SEARCH'
```

Invokes the interception script of o=proxy on bind and search operations only.

### Example 3
```powershell
Set-R1NamingContextLdapProxyAdvanced -dn 'o=proxy' -preProcessingFilter ''
```

Clears the pre-processing filter of o=proxy.

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

### -joinOptimized
Whether joins against the backend are optimized.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limitedAttributesRequested
Whether only the attributes a client requests are retrieved from the backend.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useClientSizeLimit
Whether the size limit requested by the client is applied to searches.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -preProcessingFilter
An LDAP filter applied to requests before they are sent to the backend. An empty string clears it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -postProcessingFilter
An LDAP filter applied to entries returned by the backend. An empty string clears it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -globalAttributesHandling
How each attribute is handled, each with actualName, virtualName, dnRemapping, alwaysRequested
and hidden properties.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -suffixBranchInclusion
The branches beneath the naming context to include.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -suffixBranchExclusion
The branches beneath the naming context to exclude.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectClassMapping
Object classes presented under another name, each with actualObjectClass and mappedObjectClass
properties.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -interceptOn
The operations the interception script handles.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
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

The interception script location and Java class are maintained by the server and cannot be
changed here. They are sent back unaltered so that the update carries the complete resource.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

This command has not been exercised against a live deployment.

## RELATED LINKS

[Get-R1NamingContextLdapProxyAdvanced](Get-R1NamingContextLdapProxyAdvanced)

[Set-R1NamingContextLdapProxyBackend](Set-R1NamingContextLdapProxyBackend)

[Set-R1NamingContextInterceptionScriptCode](Set-R1NamingContextInterceptionScriptCode)
