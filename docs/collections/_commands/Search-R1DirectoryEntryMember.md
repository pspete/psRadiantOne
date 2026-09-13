---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Search-R1DirectoryEntryMember

## SYNOPSIS
Searches for entries to add to a group.

## SYNTAX

```
Search-R1DirectoryEntryMember [-dn] <String> [-type] <String> [[-keywords] <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches beneath a DN for users or groups, which is how candidates for group membership are found.

## EXAMPLES

### Example 1
```powershell
Search-R1DirectoryEntryMember -dn 'o=example' -type 'USERS' -keywords 'smith'
```

Searches for users matching smith.

### Example 2
```powershell
Search-R1DirectoryEntryMember -dn 'o=example' -type 'GROUPS'
```

Returns the groups beneath a DN.

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

### -type
Whether to search for users or groups.

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

### -keywords
Limits the search to entries matching these keywords.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Entry

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Set-R1DirectoryEntryMember](Set-R1DirectoryEntryMember)

[Get-R1DirectoryEntryMember](Get-R1DirectoryEntryMember)
