---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1Aci

## SYNOPSIS
Creates an access control instruction.

## SYNTAX

```
New-R1Aci [-baseDn] <String> [[-name] <String>] [[-aciString] <String>] [[-parsable] <Boolean>]
 [[-targetDn] <String>] [[-targetScope] <String>] [[-targetFilter] <String>]
 [[-includeTargetAttributes] <Boolean>] [[-targetAttributes] <String[]>] [[-permsType] <String>]
 [[-selectedOperations] <String[]>] [[-loaOperator] <String>] [[-loaLevel] <Int32>] [[-daysOfWeek] <String[]>]
 [[-timeRanges] <String[]>] [[-applyUserDns] <String[]>] [[-applyGroupDns] <String[]>] [[-applyIps] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an access control instruction at the specified base DN.

An ACI can be described either as a raw ACI string with aciString, or with the structured parameters
covering its target, permissions, operations and the users, groups and addresses it applies to.

aciId is not accepted: the API derives it as a hash of the ACI itself.

## EXAMPLES

### Example 1
```powershell
New-R1Aci -baseDn 'cn=config' -name 'Read access' -permsType ALLOW -selectedOperations READ, SEARCH -applyUserDns 'all'
```

Creates an ACI allowing read and search for all authenticated users.

### Example 2
```powershell
New-R1Aci -baseDn 'cn=config' -aciString '(target=...)(version 3.0; acl "example"; allow(read) userdn="ldap:///anyone";)'
```

Creates an ACI from a raw ACI string.

## PARAMETERS

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

### -aciString
The ACI expressed as a raw ACI string, as an alternative to describing it with the structured parameters.

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

### -applyGroupDns
The group DNs the ACI applies to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -applyIps
The IP addresses the ACI applies to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -applyUserDns
The user DNs the ACI applies to. Accepts the keywords anyone, all, self and parent.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
The base DN the ACI applies at. Get-R1AciLocation returns the DNs which hold ACIs.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -daysOfWeek
The days the ACI applies on.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -includeTargetAttributes
Whether the target attribute expression is inclusive.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -loaLevel
The level of assurance to compare against, 0 to 4.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -loaOperator
The comparison operator used against the level of assurance, e.g. <=

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
A name for the ACI.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parsable
Whether the ACI can be represented as a structured object rather than only as a raw string.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -permsType
Whether the ACI allows or denies the selected operations. ALLOW or DENY.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ALLOW, DENY

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -selectedOperations
The operations allowed or denied. READ, WRITE, SEARCH, SELF_WRITE, ADD, PROXY, DELETE, MOVE_CURRENT, COMPARE or MOVE_FUTURE.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: READ, WRITE, SEARCH, SELF_WRITE, ADD, PROXY, DELETE, MOVE_CURRENT, COMPARE, MOVE_FUTURE

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetAttributes
The attribute names the ACI targets. Omit for all attributes.

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

### -targetDn
The DN the ACI targets.

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

### -targetFilter
An LDAP filter limiting the entries the ACI applies to.

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

### -targetScope
The scope the ACI applies over. BASE, ONE or SUBTREE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: BASE, ONE, SUBTREE

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -timeRanges
The time ranges the ACI applies during, e.g. 1030-1230

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Boolean

### System.String[]

### System.Int32

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
