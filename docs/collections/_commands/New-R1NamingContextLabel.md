---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1NamingContextLabel

## SYNOPSIS
Adds a child label node.

## SYNTAX

```
New-R1NamingContextLabel [-dn] <String> [-rdn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a label node beneath the naming context node identified by its DN. A label node groups other
nodes and holds no data of its own.

## EXAMPLES

### Example 1
```powershell
New-R1NamingContextLabel -dn 'o=views' -rdn 'ou=people'
```

Adds the label ou=people beneath o=views.

### Example 2
```powershell
'ou=people', 'ou=groups' | ForEach-Object { New-R1NamingContextLabel -dn 'o=views' -rdn $PSItem }
```

Adds two labels beneath o=views. Get-R1NamingContextChild lists them.

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

### -rdn
The RDN of the label to add.

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

## RELATED LINKS

[Get-R1NamingContextChild](Get-R1NamingContextChild)
