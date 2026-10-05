---
title: "Things Worth Knowing"
permalink: /docs/behaviour/
excerpt: "How psRadiantOne commands behave"
---

- **Updates read before they write.** Every `Set-*` command issuing a `PUT` retrieves the resource first and sends it back with the supplied values applied over it, so a property you don't specify keeps its current value.
- **Some commands replace a whole collection.** `Set-R1FIDUserRole`, `Set-R1DirectoryEntryMember`, `Set-R1LdapClientAccessMapping` and `Set-R1CustomLimit` take the complete collection, so anything omitted is removed. Their help says so.
- **Paged results are followed to the end.** A command which reads a collection returns all of it; there is no page parameter to advance by hand.
- **Secrets are secure strings.** Every password, secret and key parameter takes a `[securestring]`, and the request body carrying one is built as a byte array so it can't be captured by PowerShell's parameter binding or module logging.
- **A clean return is not always proof.** Several endpoints answer `200` to a request that did nothing, or answer with an empty result whether or not the thing addressed exists. Where that is known, the command's `NOTES` says so - read it back to confirm a change landed.
