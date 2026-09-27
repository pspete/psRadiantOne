---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/New-R1DirectoryOrganizationalUnit
schema: 2.0.0
title: New-R1DirectoryOrganizationalUnit
category: Directory Browser
---

# New-R1DirectoryOrganizationalUnit

## SYNOPSIS
Adds an organizational unit to the directory.

## SYNTAX

```
New-R1DirectoryOrganizationalUnit [-ou] <String> [-parentDn] <String> [[-description] <String>]
 [[-telephoneNumber] <String[]>] [[-facsimileTelephoneNumber] <String[]>] [[-postalAddress] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an organizationalUnit entry beneath the parent DN given, with the attributes the control panel
offers for an organizational unit.

The DN of the new entry is built from the ou and the parent DN, with the ou escaped as a DN requires.
The entry carries the object classes top and organizationalUnit.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryOrganizationalUnit -ou people -parentDn 'o=companydirectory'
```

Adds ou=people,o=companydirectory.

### Example 2
```powershell
New-R1DirectoryOrganizationalUnit -ou 'Sales, East' -parentDn 'o=companydirectory' -description 'Eastern sales'
```

Adds ou=Sales\, East,o=companydirectory, with a description.

## PARAMETERS

### -ou
The name of the organizational unit, unescaped.

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
The DN of the entry to add the organizational unit beneath.

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

### -description
A description of the organizational unit.

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

### -telephoneNumber
The telephone numbers of the organizational unit.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -facsimileTelephoneNumber
The fax numbers of the organizational unit.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -postalAddress
The postal address of the organizational unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)
