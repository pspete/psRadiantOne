---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectorySearchInfo

## SYNOPSIS
Returns the saved directory browser searches.

## SYNTAX

```
Get-R1DirectorySearchInfo [<CommonParameters>]
```

## DESCRIPTION
Returns the search tabs and history the control panel has stored for the current user. These are
the saved searches shown in the directory browser, not the results of a search.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectorySearchInfo
```

Returns the saved search tabs and history.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DirectoryBrowserSearchInfo

## NOTES

## RELATED LINKS

[Set-R1DirectorySearchInfo](Set-R1DirectorySearchInfo)
