---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1JdbcDriverLibrary

## SYNOPSIS
Returns the libraries a JDBC driver depends on.

## SYNTAX

```
Get-R1JdbcDriverLibrary [-name] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the library references the named driver file depends on.

## EXAMPLES

### Example 1
```powershell
Get-R1JdbcDriverLibrary -name 'postgresql-42.jar'
```

Returns the libraries the driver depends on.

## PARAMETERS

### -name
The name of the file.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.LibraryReference

## NOTES

## RELATED LINKS

[Set-R1JdbcDriverLibrary](Set-R1JdbcDriverLibrary)

[Get-R1JdbcDriverFile](Get-R1JdbcDriverFile)
