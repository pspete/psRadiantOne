---
title: "Installation"
permalink: /docs/install/
excerpt: "psRadiantOne download and install options"
---

## Prerequisites

- Requires PowerShell Core (recommended), or Windows PowerShell (version 5.1)
- A RadiantOne deployment or SaaS tenant
- An account with permission to access the RadiantOne API

## Install Options

Users can install psRadiantOne from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name psRadiantOne -Scope CurrentUser
```

### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `psRadiantOne`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

#### PowerShell Gallery

- Download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psRadiantOne/):
  - Run the PowerShell command `Save-Module -Name psRadiantOne -Path C:\temp`
  - Copy the `C:\temp\psRadiantOne` folder to your "Powershell Modules" directory of choice.

#### psRadiantOne Release

- [Download the latest GitHub release](https://github.com/pspete/psRadiantOne/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psRadiantOne-v#.#.#` folder to `psRadiantOne`
  - Copy the `psRadiantOne` folder to your "Powershell Modules" directory of choice.

#### psRadiantOne Branch

- [Download the `main` branch](https://github.com/pspete/psRadiantOne/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `psRadiantOne` (`\<Archive Root>\psRadiantOne-main\psRadiantOne`) folder to your "Powershell Modules" directory of choice.

### Verification

Validate Install:

```powershell

Get-Module -ListAvailable psRadiantOne

```

Import the module:

```powershell

Import-Module psRadiantOne

```

List Module Commands:

```powershell

Get-Command -Module psRadiantOne

```

Get detailed information on specific commands:

```powershell

Get-Help Connect-R1Session -Full

```
