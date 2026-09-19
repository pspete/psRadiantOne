---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Aci

## SYNOPSIS
Returns access control instructions.

## SYNTAX

### All (Default)
```
Get-R1Aci [-baseDn <String>] [<CommonParameters>]
```

### AciId
```
Get-R1Aci -aciId <Int64> -baseDn <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the access control instructions defined on the deployment.

Specify aciId together with the baseDn holding it to return a single ACI. When no aciId is given,
every ACI is returned, optionally limited to one baseDn. Get-R1AciLocation returns the DNs which
hold ACIs.

## EXAMPLES

### Example 1
```powershell
Get-R1Aci
```

Returns every access control instruction.

### Example 2
```powershell
Get-R1Aci -baseDn 'cn=config'
```

Returns the access control instructions held at the specified DN.

### Example 3
```powershell
Get-R1Aci -aciId 12345 -baseDn 'cn=config'
```

Returns a single access control instruction.

## PARAMETERS

### -aciId
The identifier of the ACI, which the API derives as a hash of the ACI itself.

```yaml
Type: Int64
Parameter Sets: AciId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
The base DN the ACI applies at. Get-R1AciLocation returns the DNs which hold ACIs.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: AciId
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

### System.Int64

### System.String

## OUTPUTS

### psRadiantOne.Aci

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
