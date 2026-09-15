---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DirectoryEntryMember

## SYNOPSIS
Sets the members of a group entry.

## SYNTAX

### Explicit (Default)
```
Set-R1DirectoryEntryMember -dn <String> -members <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Dynamic
```
Set-R1DirectoryEntryMember -dn <String> -members <String[]> [-Dynamic] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the membership of a group with the list supplied. The explicit membership is set by
default; use -Dynamic to set the dynamic group URLs instead.

## EXAMPLES

### Example 1
```powershell
Set-R1DirectoryEntryMember -dn 'cn=admins,o=example' -members 'uid=one,o=example', 'uid=two,o=example'
```

Sets the explicit membership of a group.

### Example 2
```powershell
Set-R1DirectoryEntryMember -dn 'cn=admins,o=example' -members @()
```

Empties the membership.

## PARAMETERS

### -dn
The DN of the entry.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -members
The complete membership list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Dynamic
Works on the dynamic membership rather than the explicit one.

```yaml
Type: SwitchParameter
Parameter Sets: Dynamic
Aliases:

Required: True
Position: Named
Default value: False
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

The list supplied replaces the membership, so a member left out is removed. Retrieve the current
membership with Get-R1DirectoryEntryMember and pass back the whole of it to add one.

Member values are not validated. A dn which does not exist is accepted and stored.

## RELATED LINKS

[Get-R1DirectoryEntryMember](Get-R1DirectoryEntryMember)

[Search-R1DirectoryEntryMember](Search-R1DirectoryEntryMember)
