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

### Attributes (Default)
```
Set-R1DirectoryEntry [-dn] <String> [-add <IDictionary>] [-delete <IDictionary>] [-replace <IDictionary>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Modifications
```
Set-R1DirectoryEntry [-dn] <String> [-modifications] <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies LDAP modifications to an entry. Each modification pairs a type of ADD, DELETE or REPLACE
with the attributes it affects, which is how an LDAP modify operation is expressed.

`-add`, `-delete` and `-replace` each take a hashtable keyed by attribute name, such as
`@{ l = 'London'; mail = 'one@example.test', 'two@example.test' }`. Any of them can be combined in
one call, which sends a single request applying the deletions first, then the additions, then the
replacements. A value of `$null` or `@()` is sent as an empty list of values.

`-modifications` takes the modifications in the shape the API defines, for full control over their
order.

The request body is sent as UTF8 bytes, so an attribute value carrying a credential cannot be
captured by Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Set-R1DirectoryEntry -dn 'o=example' -replace @{ description = 'Updated' }
```

Replaces the description of an entry.

### Example 2
```powershell
Set-R1DirectoryEntry -dn 'uid=one,o=example' -delete @{ telephoneNumber = $null } -add @{ mail = 'one@example.test' } -replace @{ l = 'London' }
```

Removes an attribute altogether, adds a value to another, and replaces a third, in one request.

### Example 3
```powershell
Import-Csv .\regions.csv |
    Select-Object dn, @{ n = 'replace'; e = { @{ region = $_.region } } } |
    Set-R1DirectoryEntry
```

Replaces the region of each entry listed in a CSV file with dn and region columns.

### Example 4
```powershell
$Modifications = @(
    [pscustomobject]@{ modifyType = 'DELETE'; attributes = @([pscustomobject]@{ name = 'telephoneNumber'; values = @() }) }
    [pscustomobject]@{ modifyType = 'REPLACE'; attributes = @([pscustomobject]@{ name = 'l'; values = @('London') }) }
)
Set-R1DirectoryEntry -dn 'uid=one,o=example' -modifications $Modifications
```

Sends modifications already in the shape the API defines.

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

### -add
Values to add to attributes, keyed by attribute name. The values an attribute already holds are kept.

```yaml
Type: IDictionary
Parameter Sets: Attributes
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -delete
Values to delete from attributes, keyed by attribute name. A value of `$null` or `@()` removes the
attribute entirely.

```yaml
Type: IDictionary
Parameter Sets: Attributes
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -replace
Values to replace the values of attributes with, keyed by attribute name.

```yaml
Type: IDictionary
Parameter Sets: Attributes
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -modifications
The modifications to apply, each pairing a modify type of ADD, DELETE or REPLACE with the attributes it affects.

```yaml
Type: Object[]
Parameter Sets: Modifications
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

### System.String

### System.Collections.IDictionary

### System.Object[]

## OUTPUTS

### System.Void

## NOTES

A DELETE modification with no values removes the attribute entirely. An ADD modification appends
to the values the attribute already holds, rather than replacing them.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)

[Rename-R1DirectoryEntry](Rename-R1DirectoryEntry)

[Move-R1DirectoryEntry](Move-R1DirectoryEntry)
