---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PasswordPolicy

## SYNOPSIS
Returns password policies.

## SYNTAX

### All (Default)
```
Get-R1PasswordPolicy [<CommonParameters>]
```

### PolicyName
```
Get-R1PasswordPolicy -policyName <String> [<CommonParameters>]
```

### NewPolicy
```
Get-R1PasswordPolicy [-NewPolicy] [<CommonParameters>]
```

## DESCRIPTION
Returns the password policies configured on the deployment.

With no parameters, the names of the configured policies are returned. Specify policyName to
return the full settings of one policy - the API requires it as a query parameter. Specify
NewPolicy to return an empty policy populated with the API defaults, as a starting point.

## EXAMPLES

### Example 1
```powershell
Get-R1PasswordPolicy
```

Returns the configured policy names.

### Example 2
```powershell
Get-R1PasswordPolicy -policyName 'Default'
```

Returns the full settings of the named policy.

### Example 3
```powershell
Get-R1PasswordPolicy -NewPolicy
```

Returns an empty policy populated with the API defaults.

## PARAMETERS

### -NewPolicy
Return an empty policy populated with the API defaults, as a starting point for a new one.

```yaml
Type: SwitchParameter
Parameter Sets: NewPolicy
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -policyName
The name of the password policy. Required by the API as a query parameter on retrieval, update and deletion.

```yaml
Type: String
Parameter Sets: PolicyName
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

### psRadiantOne.PasswordPolicy

## NOTES

## RELATED LINKS
