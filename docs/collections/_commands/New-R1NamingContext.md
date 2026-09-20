---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1NamingContext

## SYNOPSIS
Adds a root naming context.

## SYNTAX

```
New-R1NamingContext [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new root naming context to the directory namespace at the given DN.

## EXAMPLES

### Example 1
```powershell
New-R1NamingContext -dn 'o=mynewroot'
```

Adds a root naming context at o=mynewroot. It is a label until a backend is mounted on it or a
level added beneath it.

### Example 2
```powershell
New-R1NamingContext -dn 'o=proxy'
Mount-R1NamingContextBackend -dn 'o=proxy' -datasource 'vds' -remoteBaseDn 'o=companydirectory'
```

Adds a root naming context and mounts an LDAP directory on it.

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

### psRadiantOne.NewNamingContextResponse

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)

[Remove-R1NamingContext](Remove-R1NamingContext)
