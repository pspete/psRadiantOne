---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryEntryMember

## SYNOPSIS
Returns the members of a group entry.

## SYNTAX

### Explicit (Default)
```
Get-R1DirectoryEntryMember -dn <String> [<CommonParameters>]
```

### Dynamic
```
Get-R1DirectoryEntryMember -dn <String> [-Dynamic] [<CommonParameters>]
```

## DESCRIPTION
Returns the members of a group. The explicit membership is returned by default; use -Dynamic for
the membership resolved from a dynamic group URL.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryEntryMember -dn 'cn=admins,o=example'
```

Returns the explicit members of a group.

### Example 2
```powershell
Get-R1DirectoryEntryMember -dn 'cn=everyone,o=example' -Dynamic
```

Returns the members resolved by a dynamic group.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Set-R1DirectoryEntryMember](Set-R1DirectoryEntryMember)

[Search-R1DirectoryEntryMember](Search-R1DirectoryEntryMember)
