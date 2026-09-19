---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1StoreProperty

## SYNOPSIS
Updates the properties of a RadiantOne Directory store.

## SYNTAX

```
Set-R1StoreProperty [-dn] <String> [[-isActive] <Boolean>] [[-isSchemaChecking] <Boolean>]
 [[-isEnsureSuperiorObjectClasses] <Boolean>] [[-isNormalizeAttributeNames] <Boolean>]
 [[-indexedAttributes] <String[]>] [[-nonIndexedAttributes] <String[]>] [[-sortedAttributes] <String[]>]
 [[-encryptedAttributes] <String[]>] [[-isFullTextSearchEnabled] <Boolean>]
 [[-isOptimizeLinkAttributes] <Boolean>] [[-enableChangelog] <Boolean>] [[-asyncIndexing] <Boolean>]
 [[-isInterClusterRep] <Boolean>] [[-replicationExcludedAttributes] <String[]>] [[-storageLocation] <String>]
 [[-isEnsurePushModeEnabled] <Boolean>] [[-pushModeDataSources] <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the properties of the RadiantOne Directory store mounted at the naming context node: schema
checking, indexing, encryption, change logging and replication.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1StoreProperty -dn 'o=store' -indexedAttributes 'description'
Reset-R1StoreIndex -dn 'o=store'
```

Indexes the description attribute, then rebuilds the index, as the control panel prompts after an
index change.

### Example 2
```powershell
Set-R1StoreProperty -dn 'o=store' -isSchemaChecking $true
```

Checks the entries written to the store against the schema.

## PARAMETERS

### -dn
The DN of the store.

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

### -isActive
Whether the store is active.

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

### -isSchemaChecking
Whether entries are checked against the schema.

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

### -isEnsureSuperiorObjectClasses
Whether the superior object classes of each object class are added to entries.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isNormalizeAttributeNames
Whether attribute names are normalized to the case the schema gives them.

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

### -indexedAttributes
The attributes indexed for searching.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 7
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
Position: 8
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
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isFullTextSearchEnabled
Whether full text search is enabled.

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

### -isOptimizeLinkAttributes
Whether linked attributes are optimized.

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

### -enableChangelog
Whether changes are written to the change log.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -asyncIndexing
Whether indexing is done asynchronously.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isInterClusterRep
Whether the store takes part in inter-cluster replication.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
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
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -storageLocation
Where the store is kept. An empty string sends none.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isEnsurePushModeEnabled
Whether push mode replication is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
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
Position: 18
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

The store type, its naming context and the cache refresh flag are sent as the control panel sends
them for a RadiantOne Directory store.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

A change to the indexed attributes takes effect once the index is rebuilt with Reset-R1StoreIndex.

## RELATED LINKS

[Get-R1StoreProperty](Get-R1StoreProperty)

[Reset-R1StoreIndex](Reset-R1StoreIndex)
