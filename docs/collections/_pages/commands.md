---
title: "Command Reference"
permalink: /commands/
excerpt: "Every psRadiantOne command, grouped by area"
classes: wide
sidebar:
  nav: "docs"
---

Every command page carries the same content `Get-Help` displays, and `Get-Help <command> -Online` opens it here.

```powershell
# List every command in the module
Get-Command -Module psRadiantOne

# Get detailed help, including examples, for any command
Get-Help Connect-R1Session -Full
```

{% assign groups = site.commands | group_by: "category" | sort: "name" %}
{% for group in groups %}
## {{ group.name }}

{% assign items = group.items | sort: "title" %}
{% for command in items -%}
- [{{ command.title }}]({{ command.url | relative_url }})
{% endfor %}
{% endfor %}
