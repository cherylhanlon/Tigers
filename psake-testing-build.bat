ECHO "To run this, you need Windows PowerShell installed. Windows 7 has it built-in."

powershell -ExecutionPolicy Unrestricted -Command "& {Import-Module .\tools\psake\psake.psm1; Invoke-psake .\psake-common.ps1 FullBuildAndPublish -parameters @{'environment'='testing';'verbosity'='quiet'} }"
PAUSE