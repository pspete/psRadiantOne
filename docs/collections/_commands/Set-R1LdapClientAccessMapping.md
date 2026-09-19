---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1LdapClientAccessMapping

## SYNOPSIS
Replaces the LDAP user to DN mappings.

## SYNTAX

```
Set-R1LdapClientAccessMapping [-mappings] <Hashtable[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the complete collection of user to DN mappings.

The API takes the whole collection, so any mapping not included is removed. Retrieve the current
mappings with Get-R1LdapClientAccessMapping first if you mean to add to them rather than replace
them.

## EXAMPLES

### Example 1
```powershell
Set-R1LdapClientAccessMapping -mappings @{ userId = 'someone'; mappedDn = 'uid=someone,ou=people,dc=example,dc=com' }
```

Replaces the mappings with a single entry.

### Example 2
```powershell
$existing = @(Get-R1LdapClientAccessMapping | ForEach-Object { @{ userId = $PSItem.userId; mappedDn = $PSItem.mappedDn } })
Set-R1LdapClientAccessMapping -mappings ($existing + @{ userId = 'newuser'; mappedDn = 'uid=newuser,dc=example,dc=com' })
```

Adds a mapping to the existing collection.

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

### -mappings
The complete collection of user to DN mappings, each a hashtable with userId and mappedDn keys.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
