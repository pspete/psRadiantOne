---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1TruststoreCertificate

## SYNOPSIS
Returns client certificates from the truststore.

## SYNTAX

### All (Default)
```
Get-R1TruststoreCertificate [<CommonParameters>]
```

### Alias
```
Get-R1TruststoreCertificate -alias <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the client certificates held in the truststore. Specify an alias to return a single
certificate; when no alias is given, every certificate is returned.

## EXAMPLES

### Example 1
```powershell
Get-R1TruststoreCertificate
```

Returns every certificate in the truststore.

### Example 2
```powershell
Get-R1TruststoreCertificate -alias 'partner-ca'
```

Returns the named certificate.

## PARAMETERS

### -alias
The alias identifying the certificate in the truststore.

```yaml
Type: String
Parameter Sets: Alias
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

### System.String

## OUTPUTS

### psRadiantOne.CertificateDetails

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
