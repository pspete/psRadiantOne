---
title: "Help Us Test"
permalink: /docs/help-us-test/
excerpt: "Commands awaiting confirmation against a live deployment"
---

Prior to a 1.0.0 release, 38 of the 373 commands have not yet been exercised against a live deployment: their behaviour rests on the vendor's published API definition alone. What is left is what a test run can't reach on its own - migration and promotion, licensing, jar, library and private-file uploads, schema and directory-schema edits. Each of those commands says so in the `NOTES` section of its help.

To list them:

```powershell
Get-Command -Module psRadiantOne | Where-Object {
    (Get-Help $_.Name).alertSet.alert.Text -match 'not been exercised'
} | Select-Object -ExpandProperty Name
```

If you're able to try one of these against your own deployment, [open an issue][new-issue] with what you found - works as-is, needs a fix, or the request shape is wrong. It's genuinely the fastest way to move a command from "should work" to "confirmed".

[new-issue]: https://github.com/pspete/psRadiantOne/issues/new
