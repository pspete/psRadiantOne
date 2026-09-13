---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1LibraryDependency

## SYNOPSIS
Sets the libraries a library depends on.

## SYNTAX

```
Set-R1LibraryDependency [-groupId] <String> [-artifactId] <String> [-version] <String>
 [-dependencies] <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the dependencies of the named library with the collection supplied.

## EXAMPLES

### Example 1
```powershell
Set-R1LibraryDependency -groupId 'com.example' -artifactId 'acs' -version '1.0' -dependencies $Deps
```

Sets the dependencies of a library.

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

### -dependencies
The complete collection of libraries this library depends on.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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

The collection supplied replaces the one configured, so an entry left out is removed. Retrieve
the current collection first and pass back the whole of it to add to it.

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[Get-R1LibraryDependency](Get-R1LibraryDependency)
