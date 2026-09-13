---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryEntry

## SYNOPSIS
Returns entries from the directory.

## SYNTAX

### Root (Default)
```
Get-R1DirectoryEntry [-attributes <String[]>] [<CommonParameters>]
```

### Dn
```
Get-R1DirectoryEntry -dn <String> [-filter <String>] [-scope <String>] [-attributes <String[]>]
 [-pageSize <Int32>] [-hierarchical <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Returns the root of the directory, or the entry at a DN together with whatever the search finds
beneath it. This is both the browse and the search command: supply a filter and a scope to search.

When a page size is given the API returns a cursor, and the command follows it until every page
has been read.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryEntry
```

Returns the root of the directory.

### Example 2
```powershell
Get-R1DirectoryEntry -dn 'o=example'
```

Returns the entry at o=example.

### Example 3
```powershell
Get-R1DirectoryEntry -dn 'o=example' -scope 'SUB' -filter '(objectClass=person)'
```

Searches the whole subtree for person entries.

### Example 4
```powershell
Get-R1DirectoryEntry -dn 'o=example' -scope 'ONE' -attributes 'cn', 'mail'
```

Returns the children of o=example, with only two attributes each.

## PARAMETERS

### -dn
The DN of the entry.

```yaml
Type: String
Parameter Sets: Dn
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filter
An LDAP filter limiting which entries are returned. Without one, no filter is applied.

```yaml
Type: String
Parameter Sets: Dn
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scope
How far beneath the DN to search. BASE returns the entry alone, ONE its children, SUB the whole subtree.

```yaml
Type: String
Parameter Sets: Dn
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attributes
The attributes to return. Without any, every attribute is returned.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pageSize
The number of entries per page. The command follows the pages itself, so this changes how many requests are made, not how many entries are returned.

```yaml
Type: Int32
Parameter Sets: Dn
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -hierarchical
Returns the entries as a tree rather than a flat list. Paging is not available in this form.

```yaml
Type: Boolean
Parameter Sets: Dn
Aliases:

Required: False
Position: Named
Default value: False
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

## RELATED LINKS

[New-R1DirectoryEntry](New-R1DirectoryEntry)

[Set-R1DirectoryEntry](Set-R1DirectoryEntry)

[Remove-R1DirectoryEntry](Remove-R1DirectoryEntry)

[Close-R1DirectoryPagedSearch](Close-R1DirectoryPagedSearch)
