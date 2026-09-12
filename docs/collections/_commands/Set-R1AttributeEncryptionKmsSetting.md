---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1AttributeEncryptionKmsSetting

## SYNOPSIS
Updates the AWS KMS settings used for attribute encryption.

## SYNTAX

```
Set-R1AttributeEncryptionKmsSetting [[-accessKeyId] <SecureString>] [[-accessKeySecret] <SecureString>]
 [[-cmkRegion] <String>] [[-cmkAlias] <String>] [-useExistingCredentials] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the AWS KMS settings used for attribute encryption.

The current settings are retrieved before they are updated so that the region and alias keep
their current values when not specified. The credentials cannot be carried forward the same way,
because the retrieval reports only whether they exist: either supply them, or specify
useExistingCredentials to keep the stored ones.

The request body is sent as UTF8 bytes so that the plaintext credentials cannot be captured by
Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Set-R1AttributeEncryptionKmsSetting -cmkAlias 'alias/radiantone' -useExistingCredentials
```

Changes the key alias, keeping the stored AWS credentials.

### Example 2
```powershell
Set-R1AttributeEncryptionKmsSetting -accessKeyId $keyId -accessKeySecret $keySecret -cmkRegion 'eu-west-2'
```

Sets new AWS credentials and the key region.

## PARAMETERS

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

### -accessKeyId
The AWS access key id, as a SecureString. The retrieval reports only whether one is stored, never its value.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accessKeySecret
The AWS secret access key, as a SecureString. The retrieval reports only whether one is stored, never its value.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cmkAlias
The alias of the customer managed key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cmkRegion
The AWS region holding the customer managed key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useExistingCredentials
Keep the stored AWS credentials. Any credential supplied in the request is ignored by the API when this is specified.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
