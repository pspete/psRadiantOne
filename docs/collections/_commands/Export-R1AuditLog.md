---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1AuditLog

## SYNOPSIS
Downloads the audit logs to a file.

## SYNTAX

```
Export-R1AuditLog [-OutFile] <String> [<CommonParameters>]
```

## DESCRIPTION
Downloads the audit logs, writing the returned binary content to the file given by OutFile.

## EXAMPLES

### Example 1
```powershell
Export-R1AuditLog -OutFile .\auditlogs.zip
```

Downloads the audit logs to a file.

## PARAMETERS

### -OutFile
Path to write the downloaded audit logs to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
