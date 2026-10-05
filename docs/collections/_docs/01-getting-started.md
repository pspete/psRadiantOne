---
title: "Getting Started"
permalink: /docs/getting-started/
excerpt: "Connecting to RadiantOne and working with the session"
---

## Authenticate

Every command in the module works against a session established by `Connect-R1Session`:

```powershell
PS C:\> $Credential = Get-Credential
PS C:\> Connect-R1Session -BaseURI 'https://sometenant.example.radiantlogic.io/api' -Credential $Credential
```

`-BaseURI` takes the **API endpoint** address, not the Control Panel UI address. On a cloud tenant this is the Control Panel address with `/api` appended; both are listed in the EOC Application Endpoints panel. On a self-hosted deployment it looks like `https://radiantone.lab.local:7070/api`.

## Session Data

`Get-R1Session` returns a copy of the module scope session:

```powershell
PS C:\> Get-R1Session

BaseURI         : https://sometenant.example.radiantlogic.io/api
User            : some.user@somedomain.com
Organization    : sometenant
Version         : 8.5.3
StartTime       : 13/09/2026 22:58:13
ElapsedTime     : 00:25:30
TokenExpiry     : 13/09/2026 23:58:13
LastCommandTime : 13/09/2026 23:23:07
```

The token, the WebSession carrying it, the result of the last command and the last error are on the object but are not printed, so the session can be shown and pasted without exposing the token. Ask for them by name:

```powershell
# The privileges the token grants are worth checking when a command fails with an authorization error
PS C:\> (Get-R1Session).Privileges

# Everything the session holds
PS C:\> Get-R1Session | Select-Object -Property *
```

The WebSession carries the token, so it can be handed to `Invoke-WebRequest` for a call the module has no command for:

```powershell
PS C:\> $Session = Get-R1Session
PS C:\> Invoke-WebRequest -Uri "$($Session.BaseURI)/some-service/some_endpoint" -WebSession $Session.WebSession
```

The object is a copy: changing it does not alter the session other commands use.

`Update-R1AuthToken` renews the token, and `Disconnect-R1Session` revokes it and clears the session.
