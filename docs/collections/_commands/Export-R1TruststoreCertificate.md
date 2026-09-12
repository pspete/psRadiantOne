---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Export-R1TruststoreCertificate

## SYNOPSIS
Exports a client certificate from the truststore to a file.

## SYNTAX

```
Export-R1TruststoreCertificate [-alias] <String> [-OutFile] <String> [<CommonParameters>]
```

## DESCRIPTION
Exports the certificate held under the specified alias, writing the returned binary content to
the file given by OutFile.

## EXAMPLES

### Example 1
```powershell
Export-R1TruststoreCertificate -alias 'partner-ca' -OutFile .\partner-ca.cer
```

Writes the named certificate to a file.

## PARAMETERS

### -OutFile
Path to write the exported certificate to.

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

### -alias
The alias identifying the certificate in the truststore.

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

## RELATED LINKS
