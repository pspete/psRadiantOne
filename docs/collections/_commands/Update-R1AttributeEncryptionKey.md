---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Update-R1AttributeEncryptionKey

## SYNOPSIS
Rotates the attribute encryption key.

## SYNTAX

```
Update-R1AttributeEncryptionKey [-cipher] <String> [-secretKey] <SecureString> [[-ldifzKey] <Boolean>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the attribute encryption key and the cipher used with it, for either HDAP attribute
encryption or compressed LDIF encryption.

The request body is sent as UTF8 bytes so that the plaintext key cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Update-R1AttributeEncryptionKey -cipher AES256 -secretKey $newKey
```

Rotates the HDAP attribute encryption key.

### Example 2
```powershell
Update-R1AttributeEncryptionKey -cipher AES256 -secretKey $newKey -ldifzKey $true
```

Rotates the compressed LDIF encryption key.

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

### -cipher
The cipher to encrypt with, e.g. AES256. Get-R1AttributeEncryption reports the available ciphers.

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

### -ldifzKey
Whether the key is for compressed LDIF encryption rather than HDAP attribute encryption.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretKey
The new encryption key, as a SecureString.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

Rotating an encryption key is potentially unrecoverable. Take a backup first.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
