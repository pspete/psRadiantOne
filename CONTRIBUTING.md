# Contributing

All contributions, whether comments, code or otherwise are welcomed and appreciated.

## psRadiantOne Issues

If you find an error in `psRadiantOne`, or have a question relating to the module, [log an issue][new-issue].

## Pull Requests

When submitting a Pull Request to psPAS, automated tasks will run in Appveyor.

- Appveyor will increment the version number (there is no need to do this manually)
- The [`Pester`][pester-repo] tests for the module will run.
- [Code Coverage][code-coverage] metrics for the module will be determined
- Once code is merged into the `master` branch, and all tests pass, the module is automatically published to the PowerShell Gallery and tagged as a Release on GitHub
  - No PR's should be submitted to the master branch; submitting to the Dev branch allows for required tests & documentation to be updated prior to any code release.

## Contributing Code

- Fork the repo.
- Push your changes to your fork.
- Write [good commit messages][commit]
- If no related issue exists already, open a [New Issue][new-issue] describing the problem being fixed or feature.
- [Update documentation](#updating-documentation) for the command as required.
- Submit a pull request to the [Dev Branch][dev-branch]
  - Keep pull requests limited to a single issue
  - Discussion, or necessary changes may be needed before merging the contribution.
  - Link the pull request to the related issue

### PowerShell Styleguide

Use the standard _Verb_-_Noun_ convention, and only use approved verbs.

All Functions must have Comment Based Help.

[K&R (One True Brace Style variant)](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81) preferred.

## Updating Documentation

Project documentation, examples and all content of the help files is able to be updated.

#### External Help File

[Command Help][command-help] Markdown files are the source of truth for the `Get-Help` content of the module.

Changes to these markdown files must be reflected in the `Get-Help` content.

`platyPS` must be used to automatically generate the external help file:

```powershell
#From the module root directory, run:
import-module platyPS
New-ExternalHelp -Path .\docs\collections\_commands\ -OutputPath .\psRadiantOne\en-US\psRadiantOne-help.xml -Force
```

[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[OTBS]: https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81
[new-issue]: https://github.com/pspete/psRadiantOne/issues/new
[dev-branch]: https://github.com/pspete/psRadiantOne/tree/dev
[pester-repo]: https://github.com/pester/Pester
[code-coverage]: https://app.codecov.io/gh/pspete/psRadiantOne
[command-help]: https://github.com/pspete/psRadiantOne/tree/main/docs/collections/_commands
