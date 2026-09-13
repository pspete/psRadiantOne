---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Library

## SYNOPSIS
Returns the libraries in the catalog.

## SYNTAX

### All (Default)
```
Get-R1Library [<CommonParameters>]
```

### Coordinates
```
Get-R1Library -groupId <String> -artifactId <String> -version <String> [<CommonParameters>]
```

## DESCRIPTION
Returns every library, or one identified by its Maven coordinates. The list form follows the
pagination of the API and returns every page.

## EXAMPLES

### Example 1
```powershell
Get-R1Library
```

Returns every library.

### Example 2
```powershell
Get-R1Library -groupId 'com.example' -artifactId 'acs' -version '1.0'
```

Returns one library.

## PARAMETERS

### -groupId
The Maven group identifier of the library.

```yaml
Type: String
Parameter Sets: Coordinates
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -artifactId
The Maven artifact identifier of the library.

```yaml
Type: String
Parameter Sets: Coordinates
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -version
The version of the library.

```yaml
Type: String
Parameter Sets: Coordinates
Aliases:

Required: True
Position: Named
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

[Search-R1Library](Search-R1Library)

[Import-R1Library](Import-R1Library)

[Remove-R1Library](Remove-R1Library)

[Get-R1LibraryDependency](Get-R1LibraryDependency)
