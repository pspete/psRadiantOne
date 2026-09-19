---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1GlobalAttributeSetting

## SYNOPSIS
Updates the global attribute handling settings.

## SYNTAX

```
Set-R1GlobalAttributeSetting [[-hideOpAttrs] <Boolean>] [[-excludedHiddenOpAttrs] <String[]>]
 [[-logsExcludedAttrs] <String[]>] [[-binaryAttrs] <String[]>] [[-excludedAttrs] <String[]>]
 [[-multiValuedAttrs] <String[]>] [[-keywordSearchAttrs] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the settings governing how specific attributes are handled globally, including which are
treated as binary or multi valued and which are excluded from results, logs or keyword search.

The current settings are retrieved before they are updated, and sent back with the supplied
values applied over them, so a setting left unspecified keeps its current value. The command
therefore issues a GET followed by a PUT, and the account needs permission to read the settings
as well as to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1GlobalAttributeSetting -hideOpAttrs $true
```

Hides operational attributes, leaving every other setting as it is.

### Example 2
```powershell
Set-R1GlobalAttributeSetting -binaryAttrs 'photo', 'jpegPhoto'
```

Replaces the list of attributes treated as binary.

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

### -binaryAttrs
Attributes treated as binary.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -excludedAttrs
Attributes excluded from results.

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

### -excludedHiddenOpAttrs
Operational attributes which stay visible even when operational attributes are hidden.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -hideOpAttrs
Whether operational attributes are hidden from clients.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -keywordSearchAttrs
Attributes searched by a keyword search.

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

### -logsExcludedAttrs
Attributes whose values are kept out of the logs.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -multiValuedAttrs
Attributes treated as multi valued.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Boolean

### System.String[]

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
