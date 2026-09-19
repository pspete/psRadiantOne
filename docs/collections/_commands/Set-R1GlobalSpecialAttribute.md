---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1GlobalSpecialAttribute

## SYNOPSIS
Updates the global special attribute settings.

## SYNTAX

```
Set-R1GlobalSpecialAttribute -memberAttribute <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the attribute used to record group membership across the whole namespace.

The setting is the only property of the resource, so the value supplied is sent as the complete
request body.

## EXAMPLES

### Example 1
```powershell
Set-R1GlobalSpecialAttribute -memberAttribute 'UNIQUE_MEMBER'
```

Records group membership using the uniqueMember attribute.

## PARAMETERS

### -memberAttribute
The attribute used to record group membership.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: MEMBER, UNIQUE_MEMBER

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1GlobalSpecialAttribute](Get-R1GlobalSpecialAttribute)
