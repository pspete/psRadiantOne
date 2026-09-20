---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1CacheProperty

## SYNOPSIS
Updates the properties of a persistent cache.

## SYNTAX

```
Set-R1CacheProperty [-dn] <String> [[-isActive] <Boolean>] [[-isFullTextSearch] <Boolean>]
 [[-storageLocation] <String>] [[-isUseCacheForAuth] <Boolean>] [[-isLocalBindOnly] <Boolean>]
 [[-isDelegateOnFailure] <Boolean>] [[-isEnablePasswordPolicyEnforcement] <Boolean>]
 [[-isPasswordWriteBack] <Boolean>] [[-isOptimizeLinkedAttributes] <Boolean>]
 [[-caseSensitiveAttributesCompare] <Boolean>] [[-caseSensitiveAttributes] <String[]>]
 [[-nonIndexedAttributes] <String[]>] [[-sortedAttributes] <String[]>] [[-encryptedAttributes] <String[]>]
 [[-extensionAttributes] <String[]>] [[-invariantAttribute] <String>] [[-isInterClusterReplication] <Boolean>]
 [[-isEnsurePushMode] <Boolean>] [[-pushModeDataSources] <String[]>]
 [[-replicationExcludedAttributes] <String[]>] [[-isAcceptChangesFromReplicas] <Boolean>]
 [[-updatableAttributesFromReplicas] <String[]>] [[-changeLogEnabled] <Boolean>]
 [[-asyncIndexingEnabled] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the properties of a persistent cache: whether it is active, how it authenticates, and its
indexing, encryption, replication and change log settings.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1CacheProperty -dn 'o=directory' -isActive $false
```

Deactivates the cache at o=directory, as Deactivate Cache in the control panel does.

### Example 2
```powershell
Set-R1CacheProperty -dn 'o=directory' -isActive $true
```

Activates it again.

## PARAMETERS

### -dn
The DN of the cache.

```yaml
Type: String
Parameter Sets: (All)
Aliases: label

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isActive
Whether the cache is active.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isFullTextSearch
Whether full text search is enabled.

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

### -storageLocation
Where the cache is kept. An empty string sends none.

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

### -isUseCacheForAuth
Whether binds are authenticated against the cache.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isLocalBindOnly
Whether binds are only authenticated against the cache.

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

### -isDelegateOnFailure
Whether a bind which fails against the cache is passed to the backend.

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

### -isEnablePasswordPolicyEnforcement
Whether the password policy is enforced on binds against the cache.

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

### -isPasswordWriteBack
Whether password changes are written back to the backend.

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

### -isOptimizeLinkedAttributes
Whether linked attributes are optimized. Linked attributes must first be configured.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -caseSensitiveAttributesCompare
Whether the attributes in caseSensitiveAttributes are compared case sensitively.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -caseSensitiveAttributes
The attributes compared case sensitively.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -nonIndexedAttributes
The attributes never indexed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sortedAttributes
The attributes indexed for sorting.

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

### -encryptedAttributes
The attributes stored encrypted.

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

### -extensionAttributes
The attributes the cache holds beyond those of the view.

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

### -invariantAttribute
The attribute which identifies an entry whatever its DN. An empty string sends none.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isInterClusterReplication
Whether the cache takes part in inter-cluster replication.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isEnsurePushMode
Whether push mode replication is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pushModeDataSources
The data sources changes are pushed to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -replicationExcludedAttributes
The attributes left out of replication.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isAcceptChangesFromReplicas
Whether changes from replicas are accepted.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -updatableAttributesFromReplicas
The attributes replicas may change.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -changeLogEnabled
Whether changes are written to the change log.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -asyncIndexingEnabled
Whether indexing is done asynchronously.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
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

Whether the cache is configured and initialized, and its suffixes, are maintained by the server and
cannot be changed here. They are sent back unaltered so that the update carries the complete resource.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1CacheProperty](Get-R1CacheProperty)

[New-R1Cache](New-R1Cache)
