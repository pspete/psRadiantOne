---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/New-R1DirectoryGroup
schema: 2.0.0
title: New-R1DirectoryGroup
category: Directory Browser
---

# New-R1DirectoryGroup

## SYNOPSIS
Adds a group to the directory.

## SYNTAX

```
New-R1DirectoryGroup [-cn] <String> [-parentDn] <String> [-sAMAccountName] <String> [[-type] <String>]
 [[-description] <String>] [[-dynamic] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a group entry beneath the parent DN given, with the attributes the control panel offers for a
group.

The DN of the new entry is built from the cn and the parent DN, with the cn escaped as a DN requires.
The entry carries the object classes top and the type of group, and groupOfURLs when the group is
dynamic.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryGroup -cn Sales -sAMAccountName Sales -description 'Sales team' -parentDn 'ou=groups,o=companydirectory'
```

Adds cn=Sales,ou=groups,o=companydirectory, a static group.

### Example 2
```powershell
New-R1DirectoryGroup -cn Sales -sAMAccountName Sales -type groupOfUniqueNames -parentDn 'ou=groups,o=companydirectory'
```

Adds cn=Sales,ou=groups,o=companydirectory, a groupOfUniqueNames.

### Example 3
```powershell
New-R1DirectoryGroup -cn Sales -sAMAccountName Sales -dynamic $true -parentDn 'ou=groups,o=companydirectory'
```

Adds cn=Sales,ou=groups,o=companydirectory, a dynamic group.

## PARAMETERS

### -cn
The common name of the group.

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

### -parentDn
The DN of the entry to add the group beneath.

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

### -sAMAccountName
The account name of the group.

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

### -type
The object class of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: group, groupOfNames, groupOfUniqueNames

Required: False
Position: 4
Default value: group
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
A description of the group.

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

### -dynamic
Whether the group is dynamic, which adds the groupOfURLs object class.

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

## RELATED LINKS

[New-R1DirectoryEntry](New-R1DirectoryEntry)

[New-R1DirectoryADGroup](New-R1DirectoryADGroup)
