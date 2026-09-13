---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Save-R1DirectoryLdif

## SYNOPSIS
Downloads directory entries as an LDIF file.

## SYNTAX

```
Save-R1DirectoryLdif [-sourceDn] <String> [-scope] <String> [-fileName] <String> [-Path] <String>
 [[-targetDn] <String>] [[-maxEntries] <Int32>] [[-isExportForReplication] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Exports the entries beneath a DN and writes the LDIF into the given directory, rather than storing
it on the server. The file that was written is returned.

## EXAMPLES

### Example 1
```powershell
Save-R1DirectoryLdif -sourceDn 'o=example' -scope 'SUB' -fileName 'example.ldif' -Path 'C:\\backup'
```

Downloads a subtree as LDIF.

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

### -Path
The path of the local file to upload, or the directory to write the export into.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
Position: 5
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
Position: 6
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
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.FileInfo

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Export-R1DirectoryLdif](Export-R1DirectoryLdif)
