---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1AccessRegulationLimit

## SYNOPSIS
Updates the access regulation limits.

## SYNTAX

```
Set-R1AccessRegulationLimit [[-restrictionsIntervalPerUser] <Int32>] [[-anonymousAccessChecking] <Boolean>]
 [[-authenticatedAccessChecking] <Boolean>] [[-specialUsersAccessChecking] <Boolean>]
 [[-anonymousMaxConnections] <Int32>] [[-anonymousMaxOperationsPerSec] <Int32>]
 [[-authenticatedMaxConnections] <Int32>] [[-authenticatedMaxOperationsPerSec] <Int32>]
 [[-specialUsersMaxConnections] <Int32>] [[-specialUsersMaxOperationsPerSec] <Int32>]
 [[-specialUsersGroupDn] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the access regulation limits, which cap connections and operations per second separately for
anonymous users, authenticated users and the special users group.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1AccessRegulationLimit -anonymousAccessChecking $true -anonymousMaxConnections 10
```

Regulates anonymous access and caps it at ten concurrent connections.

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

### -anonymousAccessChecking
Whether anonymous access is regulated.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -anonymousMaxConnections
The maximum concurrent connections for anonymous users.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -anonymousMaxOperationsPerSec
The maximum operations per second for anonymous users.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -authenticatedAccessChecking
Whether authenticated access is regulated.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -authenticatedMaxConnections
The maximum concurrent connections for authenticated users.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -authenticatedMaxOperationsPerSec
The maximum operations per second for authenticated users.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -restrictionsIntervalPerUser
The interval over which per user activity is measured, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -specialUsersAccessChecking
Whether access by the special users group is regulated.

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

### -specialUsersGroupDn
The DN of the special users group these limits apply to.

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

### -specialUsersMaxConnections
The maximum concurrent connections for the special users group.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -specialUsersMaxOperationsPerSec
The maximum operations per second for the special users group.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

### System.Boolean

### System.String

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
