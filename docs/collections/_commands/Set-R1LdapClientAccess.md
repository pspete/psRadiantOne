---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1LdapClientAccess

## SYNOPSIS
Updates the LDAP client access settings.

## SYNTAX

```
Set-R1LdapClientAccess [[-pagedResults] <Boolean>] [[-virtualListView] <Boolean>]
 [[-persistentSearch] <Boolean>] [[-proxyAuthorization] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the LDAP controls offered to clients: paged results, virtual list view, persistent search and
proxy authorization.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1LdapClientAccess -pagedResults $true -persistentSearch $false
```

Enables paged results and disables persistent search.

## PARAMETERS

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

### -pagedResults
Whether the paged results control is offered to clients.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -persistentSearch
Whether the persistent search control is offered to clients.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -proxyAuthorization
Whether the proxy authorization control is offered to clients.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -virtualListView
Whether the virtual list view control is offered to clients.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
