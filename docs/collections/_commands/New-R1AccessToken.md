---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1AccessToken

## SYNOPSIS
Creates a RadiantOne access token.

## SYNTAX

```
New-R1AccessToken [-name] <String> [-apiType] <String> [[-expiresOn] <DateTime>] [[-targetDn] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an access token and returns its value.

The token value is returned only by this command and cannot be retrieved again afterwards, so it must
be captured when the token is created.

The roles associated with an access token are read-only on the token itself, and are set with
Set-R1FIDUserRole.

## EXAMPLES

### Example 1
```powershell
New-R1AccessToken -name 'Prod Service Account' -apiType CONFIG
```

Creates a CONFIG access token and returns its value.

### Example 2
```powershell
New-R1AccessToken -name 'REST Reader' -apiType REST -targetDn 'uid=svc,ou=globalusers,cn=config' -expiresOn (Get-Date).AddDays(90)
```

Creates a REST access token which assumes the specified user DN and expires in 90 days.

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

### -apiType
The API the token grants access to. CONFIG, SCIM or REST.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: CONFIG, SCIM, REST

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expiresOn
The date and time at which the access token expires. Converted to the UTC format expected by the API.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the access token to create.

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

### -targetDn
The assumed user DN when authenticating to REST. Applies only to REST type tokens.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.DateTime

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS
