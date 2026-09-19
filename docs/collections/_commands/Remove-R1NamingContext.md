---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1NamingContext

## SYNOPSIS
Deletes a naming context node.

## SYNTAX

```
Remove-R1NamingContext [-dn] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes the naming context node identified by its DN.

The node and everything configured beneath it are removed, and the deletion cannot be undone.

## EXAMPLES

### Example 1
```powershell
Remove-R1NamingContext -dn 'o=mynewroot'
```

Deletes the root naming context at o=mynewroot, after prompting for confirmation.

### Example 2
```powershell
Remove-R1NamingContext -dn 'ou=context,o=views'
```

Deletes a label together with everything configured beneath it, containers and content included.

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

### System.Void

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)

[New-R1NamingContext](New-R1NamingContext)
