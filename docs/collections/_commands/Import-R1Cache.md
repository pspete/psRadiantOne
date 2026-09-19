---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1Cache

## SYNOPSIS
Uploads an LDIF file for initializing a persistent cache.

## SYNTAX

```
Import-R1Cache [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads an LDIF file to the server, for a persistent cache to be initialized from. The file is sent as
multipart form data, and the reply of the server is returned.

## EXAMPLES

### Example 1
```powershell
Import-R1Cache -Path .\export1.ldif
```

Uploads a local LDIF file.

## PARAMETERS

### -Path
The LDIF file to upload.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: True
Position: 1
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

### System.Object

## NOTES

Initializing a cache from the uploaded file is a separate request, which Initialize-R1Cache does not
send.

## RELATED LINKS

[Initialize-R1Cache](Initialize-R1Cache)

[New-R1Cache](New-R1Cache)
