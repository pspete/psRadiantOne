---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LibraryDependency

## SYNOPSIS
Returns the libraries a library depends on.

## SYNTAX

```
Get-R1LibraryDependency [-groupId] <String> [-artifactId] <String> [-version] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the libraries the named library depends on.

## EXAMPLES

### Example 1
```powershell
Get-R1LibraryDependency -groupId 'com.example' -artifactId 'acs' -version '1.0'
```

Returns what the library depends on.

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

### psRadiantOne.LibraryReference

## NOTES

## RELATED LINKS

[Set-R1LibraryDependency](Set-R1LibraryDependency)

[Get-R1LibraryDependent](Get-R1LibraryDependent)
