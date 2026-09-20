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
Save-R1DirectoryLdif [-sourceDn] <String> [-scope] <String> [-fileName] <String> [[-Path] <String>]
 [[-targetDn] <String>] [[-maxEntries] <Int32>] [[-isExportForReplication] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Exports the entries beneath a DN and writes the LDIF into the given directory, rather than storing
it on the server. The file that was written is returned.

## EXAMPLES

### Example 1
```powershell
Save-R1DirectoryLdif -sourceDn 'o=companydirectory' -scope 'SUB' -fileName 'companydirectory.ldif' -Path 'C:\backup'
```

Exports a subtree as LDIF and downloads it into C:\backup. The server keeps a copy under a generated
name, which Remove-R1DirectoryLdifFile deletes.

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
The directory to save the file into, or the full path of the file.

Given a directory, the file is saved under the name the API sends it with. Given a full path, it
is saved under the name that path ends in. When not given, the file is saved to the current
user's Downloads directory, under the name the API sends it with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: The current user's Downloads directory
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

The server writes the export to a file of its own before returning it, under a generated name,
and does not remove it afterwards. It is listed by Get-R1DirectoryLdifFile and removed with
Remove-R1DirectoryLdifFile.

## RELATED LINKS

[Export-R1DirectoryLdif](Export-R1DirectoryLdif)
