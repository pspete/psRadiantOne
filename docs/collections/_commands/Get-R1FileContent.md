---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1FileContent

## SYNOPSIS
Returns the contents of a file on the server.

## SYNTAX

```
Get-R1FileContent [-file] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the UTF8 text contents of a file, together with its path.

## EXAMPLES

### Example 1
```powershell
Get-R1FileContent -file '/conf/app.properties'
```

Returns the contents of a file.

### Example 2
```powershell
(Get-R1FileContent -file '/conf/app.properties').contents | Set-Content .\\app.properties
```

Saves the contents to a local file.

## PARAMETERS

### -file
The path of the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

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

### psRadiantOne.FileContents

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Set-R1FileContent](Set-R1FileContent)

[Export-R1File](Export-R1File)
