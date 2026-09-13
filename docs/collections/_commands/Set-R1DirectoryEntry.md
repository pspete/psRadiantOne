---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DirectoryEntry

## SYNOPSIS
Modifies the attributes of an entry.

## SYNTAX

```
Set-R1DirectoryEntry [-dn] <String> [-modifications] <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies LDAP modifications to an entry. Each modification pairs a type of ADD, DELETE or REPLACE
with the attributes it affects, which is how an LDAP modify operation is expressed.

The request body is sent as UTF8 bytes, so an attribute value carrying a credential cannot be
captured by Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
$Modifications = @(
    [pscustomobject]@{ modifyType = 'REPLACE'; attributes = @([pscustomobject]@{ name = 'description'; values = @('Updated') }) }
)
Set-R1DirectoryEntry -dn 'o=example' -modifications $Modifications
```

Replaces the description of an entry.

### Example 2
```powershell
$Modifications = @(
    [pscustomobject]@{ modifyType = 'ADD'; attributes = @([pscustomobject]@{ name = 'mail'; values = @('one@example.test') }) }
)
Set-R1DirectoryEntry -dn 'uid=one,o=example' -modifications $Modifications
```

Adds a value to an attribute.

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

### -modifications
The modifications to apply, each pairing a modify type of ADD, DELETE or REPLACE with the attributes it affects.

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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)

[Rename-R1DirectoryEntry](Rename-R1DirectoryEntry)

[Move-R1DirectoryEntry](Move-R1DirectoryEntry)
