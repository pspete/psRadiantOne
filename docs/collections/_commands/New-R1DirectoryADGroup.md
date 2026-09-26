---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DirectoryADGroup

## SYNOPSIS
Adds an Active Directory group to the directory.

## SYNTAX

```
New-R1DirectoryADGroup [-groupName] <String> [-parentDn] <String> [[-groupScope] <String>]
 [[-groupCategory] <String>] [[-description] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a group entry beneath the parent DN given, with the attributes the control panel offers for an
Active Directory group.

The DN of the new entry is built from the group name and the parent DN, as a cn escaped as a DN
requires. The entry carries the object classes top and group.

The scope and category are sent as the groupScope and groupType attributes. A security group's
groupType has ADS_GROUP_TYPE_SECURITY_ENABLED set, so is negative.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryADGroup -groupName Sales -parentDn 'ou=groups,o=companydirectory'
```

Adds cn=Sales,ou=groups,o=companydirectory, a global security group.

### Example 2
```powershell
New-R1DirectoryADGroup -groupName 'Sales Mail' -groupScope Universal -groupCategory Distribution -description 'Sales mailing list' -parentDn 'ou=groups,o=companydirectory'
```

Adds a universal distribution group.

## PARAMETERS

### -groupName
The name of the group.

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

### -groupScope
The scope of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Global, DomainLocal, Universal

Required: False
Position: 3
Default value: Global
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groupCategory
The category of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Security, Distribution

Required: False
Position: 4
Default value: Security
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

[New-R1DirectoryGroup](New-R1DirectoryGroup)
