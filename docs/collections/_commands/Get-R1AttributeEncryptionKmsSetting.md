---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1AttributeEncryptionKmsSetting

## SYNOPSIS
Returns the AWS KMS settings used for attribute encryption.

## SYNTAX

```
Get-R1AttributeEncryptionKmsSetting [<CommonParameters>]
```

## DESCRIPTION
Returns the AWS KMS settings, covering the key region and alias, and whether an access key id
and secret are stored. The stored credentials themselves are never returned.

## EXAMPLES

### Example 1
```powershell
Get-R1AttributeEncryptionKmsSetting
```

Returns the AWS KMS settings.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.AwsKmsSettings

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
