---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1Aci

## SYNOPSIS
Reports whether an access control instruction can be parsed.

## SYNTAX

```
Test-R1Aci [-aciString] <String> [<CommonParameters>]
```

## DESCRIPTION
Reports whether the API can parse an ACI given as a string, and returns it broken into its parts.
Nothing is created.

An ACI which parses comes back with parsable true and its target, permissions and restrictions
filled in. One which does not comes back with parsable false.

To build an ACI from individual permissions rather than a string, use New-R1Aci, which takes the
target, the operations and the restrictions as parameters.

## EXAMPLES

### Example 1
```powershell
Test-R1Aci -aciString '(targetattr = "*")(target = "ldap:///cn=schema")(targetscope = "base")(version 3.0;acl "update schema";allow (all) (groupdn = "ldap:///cn=directory administrators,ou=globalgroups,cn=config");)'
```

Reports whether the ACI string can be parsed, and returns its parts.

### Example 2
```powershell
Get-R1Aci | Test-R1Aci
```

Checks every ACI configured on the deployment.

## PARAMETERS

### -aciString
The ACI as a string.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.Aci

## NOTES

The endpoint is a GET which carries the ACI as its request body, and reads that body as the ACI
string itself rather than as JSON.

## RELATED LINKS

[New-R1Aci](New-R1Aci)

[Get-R1Aci](Get-R1Aci)

[Set-R1Aci](Set-R1Aci)