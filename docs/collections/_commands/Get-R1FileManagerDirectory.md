---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1FileManagerDirectory

## SYNOPSIS
Lists a directory on the server.

## SYNTAX

```
Get-R1FileManagerDirectory [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Lists the files and folders in a directory. Without a path, the base directory is listed.

## EXAMPLES

### Example 1
```powershell
Get-R1FileManagerDirectory
```

Lists the base directory.

### Example 2
```powershell
Get-R1FileManagerDirectory -path '/conf'
```

Lists the conf directory.

## PARAMETERS

### -path
The directory path, relative to the base directory the API allows.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### psRadiantOne.Directory

## NOTES

## RELATED LINKS

[New-R1FileManagerDirectory](New-R1FileManagerDirectory)

[Remove-R1FileManagerDirectory](Remove-R1FileManagerDirectory)

[Get-R1FileContent](Get-R1FileContent)
