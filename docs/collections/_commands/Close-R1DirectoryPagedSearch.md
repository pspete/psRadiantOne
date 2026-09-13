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

Closes the paging session.

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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)
