---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1DirectoryLdif

## SYNOPSIS
Exports directory entries to an LDIF file on the server.

## SYNTAX

```
Export-R1DirectoryLdif [-sourceDn] <String> [-scope] <String> [-fileName] <String> [[-targetDn] <String>]
 [[-maxEntries] <Int32>] [[-isExportForReplication] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Exports the entries beneath a DN to an LDIF file held on the server. Use Get-R1DirectoryLdifFile to
list what has been exported, or Save-R1DirectoryLdif to download instead of storing.

## EXAMPLES

### Example 1
```powershell
Export-R1DirectoryLdif -sourceDn 'o=example' -scope 'SUB' -fileName 'example.ldif'
```

Exports a subtree to a file on the server.

### Example 2
```powershell
Export-R1DirectoryLdif -sourceDn 'o=example' -scope 'SUB' -fileName 'example.ldif' -targetDn 'o=copy'
```

Exports a subtree, rewriting the entries under a different DN.

## PARAMETERS

### -sourceDn
The DN to export from.

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

### -scope
How far beneath the DN to search. BASE returns the entry alone, ONE its children, SUB the whole subtree.

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

### -fileName
The name of the LDIF file, which must end .ldif or .ldifz.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetDn
The DN to rewrite the exported entries under.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -maxEntries
The greatest number of entries to export.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isExportForReplication
Produces an export suitable for seeding a replica.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
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

[Save-R1DirectoryLdif](Save-R1DirectoryLdif)

[Get-R1DirectoryLdifFile](Get-R1DirectoryLdifFile)

[Import-R1DirectoryLdif](Import-R1DirectoryLdif)
