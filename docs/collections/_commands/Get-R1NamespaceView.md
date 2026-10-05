---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version: https://psradiantone.pspete.dev/commands/Get-R1NamespaceView
schema: 2.0.0
title: Get-R1NamespaceView
category: Namespace Views
---

# Get-R1NamespaceView

## SYNOPSIS
Returns the view files defined in the namespace.

## SYNTAX

```
Get-R1NamespaceView [<CommonParameters>]
```

## DESCRIPTION
Returns every view file defined in the directory namespace, with the time each was last modified.

## EXAMPLES

### Example 1
```powershell
Get-R1NamespaceView
```

Returns every view defined in the namespace.

### Example 2
```powershell
Get-R1NamespaceView | Sort-Object lastModified -Descending
```

Returns the views, most recently modified first.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ViewFile

## NOTES

## RELATED LINKS

[Remove-R1NamespaceView](Remove-R1NamespaceView)

[New-R1NamingContextLink](New-R1NamingContextLink)
