---
title: "psRadiantOne"
layout: splash
permalink: /
excerpt: "PowerShell module for the Radiant Logic RadiantOne REST API."
header:
  overlay_image: /assets/images/banner.png
  overlay_filter: rgba(40, 106, 205, 0.9)
  actions:
    - label: "GitHub"
      url: "https://github.com/pspete/psRadiantOne"
    - label: "PowerShell Gallery"
      url: "https://www.powershellgallery.com/packages/psRadiantOne/"
    - label: "GitHub Sponsors"
      url: "https://github.com/sponsors/pspete"
feature_row:
  - image_path: /assets/images/install.png
    title: "Install Options"
    excerpt: "Install psRadiantOne from the PowerShell Gallery, a GitHub release, or the main branch."
    url: "/docs/install/"
    btn_label: "Read More"
    btn_class: "btn--light-outline"
  - image_path: /assets/images/import.png
    title: "Getting Started"
    excerpt: "Connect to a RadiantOne deployment or SaaS tenant, and work with the session."
    url: "/docs/getting-started/"
    btn_label: "Read More"
    btn_class: "btn--light-outline"
  - image_path: /assets/images/help.png
    title: "Command Reference"
    excerpt: "Syntax, parameters and examples for every psRadiantOne command."
    url: "/commands/"
    btn_label: "Read More"
    btn_class: "btn--light-outline"
---

{% include feature_row %}

psRadiantOne wraps the REST API of the [Radiant Logic RadiantOne](https://www.radiantlogic.com/) platform. It gives you commands for authentication and administration - the global namespace, the directory schema and browser, data sources and schemas, security settings, tasks, configuration promotion and the file manager - all from within PowerShell.

The module covers the RadiantOne v8.x API as published in the vendor's OpenAPI definition, and targets both self-hosted deployments and SaaS tenants.

```powershell
Install-Module -Name psRadiantOne -Scope CurrentUser

Connect-R1Session -BaseURI 'https://sometenant.example.radiantlogic.io/api' -Credential (Get-Credential)

Get-R1NamingContext
```

psRadiantOne is pre-1.0. Command names, parameters and grouping may still change as real-world usage shapes them. [Issues](https://github.com/pspete/psRadiantOne/issues) and pull requests are encouraged.
{: .notice--warning}
