---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1BackendLimit

## SYNOPSIS
Updates the backend limits.

## SYNTAX

```
Set-R1BackendLimit [[-jndiPoolSize] <Int32>] [[-jndiConnectTimeout] <Int32>] [[-jndiOperationTimeout] <Int32>]
 [[-ldapWriteOperationTimeout] <Int32>] [[-jndiIdleTimeout] <Int32>] [[-jdbcPoolSize] <Int32>]
 [[-jdbcIdleTimeout] <Int32>] [[-jdbcPreparedStmtCache] <Int32>] [[-srvRecordLimit] <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the backend connection limits, covering LDAP and JDBC pool sizes, timeouts and the SRV record
lookup limit.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1BackendLimit -jdbcPoolSize 40
```

Raises the JDBC connection pool size.

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

### -jdbcIdleTimeout
How long a pooled JDBC connection may be idle, in minutes.

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

### -jdbcPoolSize
The maximum connections pooled to each JDBC data source.

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

### -jdbcPreparedStmtCache
How many prepared statements are cached per JDBC connection.

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

### -jndiConnectTimeout
How long to wait for a backend LDAP connection, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jndiIdleTimeout
How long a pooled LDAP connection may be idle, in minutes.

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

### -jndiOperationTimeout
How long to wait for a backend LDAP response, in seconds. Zero for no limit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jndiPoolSize
The maximum connections pooled to each LDAP data source.

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

### -ldapWriteOperationTimeout
How long to wait for a backend LDAP write or bind response, in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -srvRecordLimit
How many hosts are used from an SRV record lookup.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### System.Void

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
