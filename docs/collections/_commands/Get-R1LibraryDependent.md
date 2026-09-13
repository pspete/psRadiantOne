---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LibraryDependent

## SYNOPSIS
Returns the libraries which depend on a library.

## SYNTAX

```
Get-R1LibraryDependent [-groupId] <String> [-artifactId] <String> [-version] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the libraries which refer to the named library, which is what makes it unsafe to remove.

## EXAMPLES

### Example 1
```powershell
Get-R1LibraryDependent -groupId 'com.example' -artifactId 'acs' -version '1.0'
```

Returns what depends on the library.

## PARAMETERS

### -groupId
The Maven group identifier of the library.

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

### -artifactId
The Maven artifact identifier of the library.

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

### -version
The version of the library.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.Library

## NOTES

## RELATED LINKS

[Get-R1LibraryDependency](Get-R1LibraryDependency)

[Remove-R1Library](Remove-R1Library)
