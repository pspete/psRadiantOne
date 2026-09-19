---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Close-R1DirectoryPagedSearch

## SYNOPSIS
Closes a paged search session.

## SYNTAX

```
Close-R1DirectoryPagedSearch [-cookie] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Releases a paging session the server is holding open, identified by the cursor from a paged
search. Get-R1DirectoryEntry reads every page and so leaves no session behind; this is for a
session abandoned part way through.

## EXAMPLES

### Example 1
```powershell
Close-R1DirectoryPagedSearch -cookie $Cursor
```

Closes a paged search which is not going to be read to the end, releasing it on the server. The
cursor is the one returned with a page of search results. Get-R1DirectoryEntry reads every page of a
search itself, so it leaves nothing to close.

## PARAMETERS

### -cookie
The cursor identifying the paging session to close.

```yaml
Type: String
Parameter Sets: (All)
Aliases: cursor

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

Get-R1DirectoryEntry follows a paged search to its end, leaving no open cursor behind it. This
command applies to a search which the caller pages itself.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)
