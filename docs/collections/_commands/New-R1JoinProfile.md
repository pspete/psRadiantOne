---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1JoinProfile

## SYNOPSIS
Builds the definition of a join for the object builder.

## SYNTAX

```
New-R1JoinProfile [-dn] <String> [-primaryObject] <String> [-name] <String> [-joinInputSource] <Object>
 [-joinCondition] <String> [[-returnAttributes] <String[]>] [[-returnAllAttributes] <Boolean>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds the definition of a join from the primary object to another input source of its object
model, on the join condition given, returning the attributes named.

Nothing is saved on the server. The definition is returned so that it can be added to the object
model and saved with Set-R1SecondaryObject, as the SAVE button of the object builder does.

## EXAMPLES

### Example 1
```powershell
$Source = New-R1ObjectInputSource -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -targetBaseDn 'ou=Human Resources,o=companydirectory' -objectClass 'inetOrgPerson' -scope 'SUB' -sizeLimit 1
$Condition = (Get-R1JoinCondition -secondaryObject 'inetOrgPerson' -primaryJoinAttribute 'EMPLOYEEID' -secondaryJoinAttribute 'employeeNumber').joinCondition
$Join = New-R1JoinProfile -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -name 'northwind_vds' -joinInputSource $Source -joinCondition $Condition -returnAttributes 'mail'
$Model = Get-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
Set-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -inputSources (@($Model.inputSources) + $Source) -joins (@($Model.joins) + $Join)
```

Joins each employee to the directory entry whose employeeNumber matches their EMPLOYEEID, returning
the mail attribute, and saves the join in the model.

## PARAMETERS

### -dn
The DN of the naming context node.

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

### -primaryObject
The name of the primary object, as Get-R1PrimaryObject returns it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the join.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -joinInputSource
The input source joined to, as New-R1ObjectInputSource returns it or as it appears in the
inputSources of the model.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -joinCondition
The join condition, in the form (&(employeeNumber=@[EMPLOYEEID:varchar])(objectclass=inetOrgPerson)).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -returnAttributes
The attributes of the joined source to return.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -returnAllAttributes
Whether every attribute of the joined source is returned.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.JoinProfile

## NOTES

## RELATED LINKS

[New-R1ObjectInputSource](New-R1ObjectInputSource)

[Get-R1JoinCondition](Get-R1JoinCondition)

[Test-R1JoinCondition](Test-R1JoinCondition)

[Set-R1SecondaryObject](Set-R1SecondaryObject)
