---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextSpecialAttribute

## SYNOPSIS
Updates the special attribute settings of a naming context.

## SYNTAX

```
Set-R1NamingContextSpecialAttribute [-dn] <String> [[-linkedAttributes] <Object[]>]
 [[-dynamicGroupSettings] <Object>] [[-unnestGroups] <String[]>] [[-referentialIntegrityRules] <Object[]>]
 [[-attributeUniquenessRules] <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the special attribute settings configured on the naming context node.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextSpecialAttribute -dn 'o=vds' -unnestGroups 'ou=groups,o=vds'
```

Sets the unnested groups of o=vds, leaving its other special attribute settings as they are.

### Example 2
```powershell
$Current = Get-R1NamingContextSpecialAttribute -dn 'o=vds'
Set-R1NamingContextSpecialAttribute -dn 'o=vds' -unnestGroups ($Current.unnestGroups + 'ou=more,o=vds')
```

Adds a group to the unnested groups, by retrieving the current list and passing back the whole of it.

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

### -linkedAttributes
The linked attribute mappings, each pairing a target DN and backlink attribute with the source DNs and forward link attributes that populate it.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dynamicGroupSettings
The dynamic group settings, being the member attribute and the dynamic groups defined.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -unnestGroups
The DNs of the groups whose nested membership is flattened.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -referentialIntegrityRules
The referential integrity rules.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attributeUniquenessRules
The attribute uniqueness rules.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1NamingContextSpecialAttribute](Get-R1NamingContextSpecialAttribute)

[Set-R1GlobalSpecialAttribute](Set-R1GlobalSpecialAttribute)
