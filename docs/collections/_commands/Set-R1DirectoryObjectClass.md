---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DirectoryObjectClass

## SYNOPSIS
Updates an object class in the directory schema.

## SYNTAX

```
Set-R1DirectoryObjectClass [-objectClass] <String> [[-superClass] <String>] [[-isAuxiliary] <Boolean>]
 [[-requiredAttrs] <Object[]>] [[-optionalAttrs] <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the definition of an object class in the LDAP schema.

The current definition is retrieved before it is updated, and sent back with the supplied values
applied over it, so a property left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the definition as well
as to change it.

## EXAMPLES

### Example 1
```powershell
Set-R1DirectoryObjectClass -objectClass 'myPerson' -superClass 'organizationalPerson'
```

Changes the class myPerson inherits from, leaving its other properties as they are.

## PARAMETERS

### -objectClass
The name of the object class.

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

### -superClass
The object class this one inherits from.

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

### -isAuxiliary
Whether the object class is auxiliary rather than structural.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requiredAttrs
The attributes an entry of this object class must carry.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -optionalAttrs
The attributes an entry of this object class may carry.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

The object identifier and whether the class is user defined are maintained by the server and
cannot be changed here. They are sent back unaltered so that the update carries the complete
definition.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1DirectoryObjectClass](Get-R1DirectoryObjectClass)

[New-R1DirectoryObjectClass](New-R1DirectoryObjectClass)
