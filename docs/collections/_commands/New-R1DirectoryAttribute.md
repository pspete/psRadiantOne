---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DirectoryAttribute

## SYNOPSIS
Adds an attribute to the directory schema.

## SYNTAX

```
New-R1DirectoryAttribute [-name] <String> [[-alias] <String[]>] [[-oid] <String>] [[-description] <String>]
 [[-syntax] <String>] [[-multiValued] <Boolean>] [[-operational] <Boolean>] [[-isRequired] <Boolean>]
 [[-isHiddenInLogs] <Boolean>] [[-objectclass] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new attribute to the LDAP schema.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryAttribute -name 'employeeShift' -syntax 'Directory String syntax'
```

Adds a single valued string attribute called employeeShift.

### Example 2
```powershell
New-R1DirectoryAttribute -name 'employeeShift' -syntax 'Directory String syntax' -multiValued $true -alias 'shift'
```

Adds a multi valued attribute with an alias.

## PARAMETERS

### -name
The name of the attribute.

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
Alternative names for the attribute.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -oid
The object identifier of the attribute.

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

### -description
A description of the attribute.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -syntax
The LDAP syntax of the attribute. Get-R1DirectoryAttributeSyntax lists those the deployment supports.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -multiValued
Whether the attribute may hold more than one value.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operational
Whether the attribute is operational, and so not returned unless asked for by name.

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

### -isRequired
Whether the attribute is required.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isHiddenInLogs
Whether the value of the attribute is hidden in the logs.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectclass
The object class the attribute belongs to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
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

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DirectoryAttribute](Get-R1DirectoryAttribute)

[Get-R1DirectoryAttributeSyntax](Get-R1DirectoryAttributeSyntax)
