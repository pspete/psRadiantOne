# .ExternalHelp psRadiantOne-help.xml
function Get-R1Task {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Task')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Id'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('taskId')]
		[string]$id
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'tasks'

		if ($PSCmdlet.ParameterSetName -eq 'Id') {

			$Path = "$Path/$($id | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Task

		}

	}#process

	End { }#end

}
