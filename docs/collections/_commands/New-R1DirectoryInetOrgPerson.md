---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/New-R1DirectoryInetOrgPerson
schema: 2.0.0
title: New-R1DirectoryInetOrgPerson
category: Directory Browser
---

# New-R1DirectoryInetOrgPerson

## SYNOPSIS
Adds an inetOrgPerson to the directory.

## SYNTAX

```
New-R1DirectoryInetOrgPerson [-cn] <String> [-sn] <String> [-parentDn] <String> [[-namingAttribute] <String>]
 [[-uid] <String>] [[-givenName] <String>] [[-mail] <String[]>] [[-telephoneNumber] <String[]>]
 [[-facsimileTelephoneNumber] <String[]>] [[-password] <SecureString>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds an inetOrgPerson entry beneath the parent DN given, with the attributes the control panel offers
for an inetOrgPerson.

The entry is named by its cn, or by its uid when namingAttribute is uid, escaped as a DN requires.
The entry carries the object classes top, person, organizationalPerson and inetOrgPerson.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryInetOrgPerson -cn 'Jane Smith' -sn Smith -givenName Jane -parentDn 'ou=people,o=companydirectory'
```

Adds cn=Jane Smith,ou=people,o=companydirectory.

### Example 2
```powershell
$Password = Read-Host -AsSecureString
New-R1DirectoryInetOrgPerson -cn 'Jane Smith' -sn Smith -uid jsmith -namingAttribute uid -mail 'jsmith@company.com' -password $Password -parentDn 'ou=people,o=companydirectory'
```

Adds uid=jsmith,ou=people,o=companydirectory, with a mail address and a password.

## PARAMETERS

### -cn
The common name of the person.

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

### -sn
The surname of the person.

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

### -parentDn
The DN of the entry to add the person beneath.

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

### -namingAttribute
The attribute which names the entry in its DN. A uid must be given to name the entry by its uid.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: cn, uid

Required: False
Position: 4
Default value: cn
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -uid
The user ID of the person.

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

### -givenName
The given name of the person.

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

### -mail
The mail addresses of the person.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -telephoneNumber
The telephone numbers of the person.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -facsimileTelephoneNumber
The fax numbers of the person.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -password
The password of the person, sent as the userPassword attribute.

```yaml
Type: SecureString
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

## RELATED LINKS

[New-R1DirectoryEntry](New-R1DirectoryEntry)

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)
