# .ExternalHelp psRadiantOne-help.xml
function Get-R1TaskLog {
	[CmdletBinding(DefaultParameterSetName = 'Download')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'Tail'
		)]
		[ValidateRange(1, 2000)]
		[int]$numberOfLines
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Tail') {

			#Told how many lines to return, the endpoint returns them and closes. Asked without
			#numberOfLines it follows the log and never closes, which is why the parameter is
			#mandatory rather than defaulted.
			$Query = $PSBoundParameters | Get-Parameter -ParametersToKeep numberOfLines | ConvertTo-QueryString

			$Path = "tasks/$($id | Get-EscapedString)/logs/tail`?$Query"

		} else {

			$Path = "tasks/$($id | Get-EscapedString)/logs"

		}

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			if ($Result -is [string]) {

				#The two endpoints disagree: a tail answers with an array of lines, a download with
				#the whole log as one string. Return lines either way.
				$Result.TrimEnd("`r", "`n") -split '\r?\n'

			} else {

				$Result

			}

		}

	}#process

	End { }#end

}
