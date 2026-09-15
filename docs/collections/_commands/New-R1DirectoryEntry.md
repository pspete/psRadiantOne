---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DirectoryEntry

## SYNOPSIS
Adds an entry to the directory.

## SYNTAX

```
New-R1DirectoryEntry [-dn] <String> [-attributes] <Object[]> [[-rdn] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds an entry at the given DN with the attributes supplied.

The request body is sent as UTF8 bytes, so an attribute value carrying a credential cannot be
captured by Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
$Attributes = @(
    [pscustomobject]@{ name = 'objectClass'; values = @('top', 'organizationalUnit') }
    [pscustomobject]@{ name = 'ou'; values = @('people') }
)
New-R1DirectoryEntry -dn 'ou=people,o=example' -attributes $Attributes
```

Adds an organizational unit.

## PARAMETERS

### -dn
The DN of the entry.

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

### -attributes
The attributes to return. Without any, every attribute is returned.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -rdn
The RDN of the entry. The API names the new entry by its dn, so this is not a way to create a
child of the dn given.

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

The dn is the dn of the entry to create. Supplying the dn of the parent entry with an rdn does
not create a child: the API attempts to create the dn given, and fails because it already
exists.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)

[Set-R1DirectoryEntry](Set-R1DirectoryEntry)
