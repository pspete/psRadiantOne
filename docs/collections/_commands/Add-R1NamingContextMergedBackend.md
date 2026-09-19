---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Add-R1NamingContextMergedBackend

## SYNOPSIS
Adds a merged backend to an LDAP proxy naming context.

## SYNTAX

```
Add-R1NamingContextMergedBackend [-dn] <String> [-radiantoneNamespaceDn] <String> [-dataSource] <String>
 [-remoteBaseDn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Merges the entries beneath a DN in a second LDAP data source into the LDAP proxy naming context
node, presenting them at the RadiantOne namespace DN given.

## EXAMPLES

### Example 1
```powershell
Add-R1NamingContextMergedBackend -dn 'o=proxy' -radiantoneNamespaceDn 'ou=sample,o=proxy' -dataSource 'vds' -remoteBaseDn 'ou=ad_sample,ou=AllProfiles'
```

Presents ou=ad_sample,ou=AllProfiles of the vds data source at ou=sample,o=proxy.

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

### -radiantoneNamespaceDn
The DN at which the merged entries are presented, beneath the naming context node.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSource
The name of the LDAP data source to merge.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -remoteBaseDn
The DN in the data source whose entries are merged.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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

This command has not been exercised against a live deployment.

## RELATED LINKS

[Get-R1NamingContextMergedBackend](Get-R1NamingContextMergedBackend)

[Remove-R1NamingContextMergedBackend](Remove-R1NamingContextMergedBackend)
