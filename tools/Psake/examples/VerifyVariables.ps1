﻿properties {
	$x = 1
}

FormatTaskName "[{0}]"

task default -depends Verify 

task Verify -description "This task verifies psake's variables" {

	#Verify the exported module variables
	cd variable:	
	Assert (Test-Path "psake") "variable psake was not exported from module"
	
	Assert ($psake.ContainsKey("build_success")) "psake variable does not contain 'build_success'"
	Assert ($psake.ContainsKey("use_exit_on_error")) "psake variable does not contain 'use_exit_on_error'"
	Assert ($psake.ContainsKey("log_error")) "psake variable does not contain 'log_error'"
	Assert ($psake.ContainsKey("version")) "psake variable does not contain 'version'"
	Assert ($psake.ContainsKey("build_script_file")) "psake variable does not contain 'build_script_file'"
	Assert ($psake.ContainsKey("framework_version")) "psake variable does not contain 'framework_version'"
	
	Assert (!$psake.build_success) 'psake.build_success should be $false'
	Assert (!$psake.use_exit_on_error) 'psake.use_exit_on_error should be $false'
	Assert (!$psake.log_error) 'psake.log_error should be $false'
	Assert (![string]::IsNullOrEmpty($psake.version)) 'psake.version was null or empty'
	Assert ($psake.build_script_file -ne $null) '$psake.build_script_file was null' 
	Assert ($psake.build_script_file.Name -eq "VerifyVariables.ps1") ("psake variable: {0} was not equal to 'VerifyVariables.ps1'" -f $psake.build_script_file.Name)
	Assert (![string]::IsNullOrEmpty($psake.framework_version)) 'psake variable: $psake.framework_version was null or empty'

	#Verify script-level variables 
	Assert ($tasks.Count -ne 0) 'psake variable: $tasks had length zero'
	Assert ($properties.Count -ne 0) 'psake variable: $properties had length zero'
	Assert ($includes.Count -eq 0) 'psake variable: $includes should have had length zero'	
	Assert ($formatTaskNameString -eq "[{0}]") 'psake variable: $formatTaskNameString was not set correctly'
	Assert ($currentTaskName -eq "Verify") 'psake variable: $currentTaskName was not set correctly'
}