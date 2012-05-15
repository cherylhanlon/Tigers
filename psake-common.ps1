Include ".\psake-includes.ps1"

# INJECTING PARAMETERS
# Can set any properties dynamically by calling for example:
# Invoke-psake .\psake-common.ps1 -parameters @{"environment"="live";"verbosity"="detailed"} 

# RUNNING USING POWERSHELL INTERACTIVELY
# If you are not an administrator, will need to:
# Set-ExecutionPolicy Unrestricted
# You will always need to import the psake module:
# Import-Module .\tools\Psake\psake.psm1
# Then run psake giving it your build file and the task(s) to run:
# Invoke-psake .\psake-common.ps1 FullBuild -parameters @{"environment"="live";"verbosity"="quiet"} 

properties { 
    $project_name  = "Tigers.Website"
    $project_display_name  = "Tigers Website"
	$projects_to_consolidate = "N2.Management" #Add projects to this space seperated list if you need their contents added into the main website (eg. for N2)
    $version = "" # Will be generated: $versionMajor.$versionMinor.Svn Revision Number
	$versionMajor = 0
	$versionMinor = 0
} 

properties { #Settings
	$environment = "development" #live, staging, testing, development
    $msbuild_location = "msbuild" #Default arg for calling msbuild.exe, works on 32bit. On 64 bit have to set this to hardcoded 32bit msbuild.exe path (see SetBuildConfiguration)
	$build_configuration # Dynamic: See SetBuildConfiguration
    $verbosity = "normal" #quiet, minimal, normal, detailed
	$clsCompliant = "false" #For extra build warnings
}

properties { # Directories
    $base_dir  = resolve-path .
    $logs_dir  = "$base_dir\logs"
    $lib_dir = "$base_dir\lib"
    $build_dir = "$base_dir\build" 
    $src_dir = "$base_dir\src"
    $main_project_src_dir = "$src_dir\$project_name"
    $tools_dir = "$base_dir\tools"
    $publish_dir = "$base_dir\publish"
    $built_websites_dir = "$build_dir\_PublishedWebsites"
    $built_main_website_dir = "$built_websites_dir\$project_name"
    $built_main_website_content_dir = "$built_main_website_dir\Content" #Directory containing .js, .css, images etc
}

properties { #Deployment
	$deployment_targets = @{"$project_name" = @{"testing" = "\\spidey\d$\wwwroot\Tigers.Website"; "staging" = "\\tigerswebsite\d$\websites\Tigers.Website"; "development" = "C:\\inetpub\\wwwroot\\Tigers.Website"; "live" = "\\hyperion\e$\Deployments\Tigers\Website"}; }
	$exes_to_publish =  @()
    $publish_file_exclusions = @() #filenames specified as comma separated list of strings that will be matched anywhere in folder structure. Can take wildcards eg '*.jpg'
    $publish_directory_exclusions = @('Tigers.Website\Upload') #specify the folder or exact file name as comma separated list of strings starting from the published project folder eg 'MyWebsite\AnyNumberOfSubFolders\FolderToExclude'
}

properties { # Files
    $sln_file = "$src_dir\$project_name.sln" 
}

properties { # Projects
    $projects_needing_assembly_info = ($project_name, "$project_name.Specs")
}

properties { # Assemblies
	$ncover_exclusion_attributes = "$project_name.Infrastructure.NoCoverageAttribute;System.Runtime.CompilerServices.CompilerGeneratedAttribute;Management.N2;N2.Templates.*" #Semicolon-seperated list
    $ncover_monitored_assemby_names = ($project_name) #, 'Another.Assembly')
    $gendarme_monitored_assembly_names = ("$build_dir\$project_name.dll") #, 'Another.Assembly') # Note: .exe or .dll depending on project
    $test_assembly_names = ("$project_name.Specs") #, $project_name.Tests.Integration")
    $test_assembly_paths = ("$build_dir\$project_name.Specs.dll") #, "$build_dir\$project_name.Tests.Integration.dll")  
}

properties { # Tools
    $subsonic_exe = "$tools_dir\Subsonic\SubCommander\sonic.exe"
    $microsoft_ajax_minifier = "$tools_dir\MicrosoftAjaxMinifier\ajaxmin"
    $packer_dot_net = "$tools_dir\packer.net\packer"
    $ncover_exe = "$tools_dir\ncover\ncover.console.exe"
    $mspec_exe = "$lib_dir\mspec\mspec.exe"
    $ncover_explorer_exe = "$tools_dir\ncoverexplorer\ncoverexplorer.console.exe"
    $fxcop_exe = "$tools_dir\fxcop\FxCopCmd.exe"
    $gendarme_exe = "$tools_dir\gendarme\gendarme.exe"
    $corflags_exe = "$tools_dir\CorFlags\CorFlags.exe"
}

task default -depends QuickBuild

task QuickBuild -depends Build

task FullBuild -depends QuickBuild, RunMSpecTestsWithNcover, RunNcoverExplorer, RunGendarme, RunFxCop, RunSourceMonitor

task FullBuildAndPublish -depends SetConfigFilesForEnv, Build, RunMSpecTestsWithNcover, Publish, ResetEnvironment, ConsolidatePublish

task SetConfigFilesForEnv {

    # Search for environment-specific config files ending with .testing .staging or .live depending on environment 
    # (e.g. log4net.config.testing),
    # find the config file its supposed to replace (e.g. log4net.config),
    # make a backup of the config file (log4net.config.psakeTemp) and overwrite with the environment specific file.
    
    Display-Info "Renaming config files for $environment environment"
	
    $projectSrcDirectories = Get-ChildItem $src_dir | Where {$_.psIsContainer -eq $true}
    
    foreach($projectSrcDirectory in $projectSrcDirectories) {

        foreach($envSpecificConfigFile in Get-ChildItem  $projectSrcDirectory.FullName -recurse -Filter *.$environment) {

            #Find the file we need to replace with the env specific one
            $fileToReplace = Get-ChildItem  $projectSrcDirectory.FullName -recurse -Filter $envSpecificConfigFile.BaseName

            if($fileToReplace -eq $null) {  
                Display-Warning ("Error moving $envSpecificConfigFile: Didn't find a matching file to replace (looking for " + $envSpecificConfigFile.BaseName + " in " + $projectSrcDirectory.FullName + ").")
            } else {
                Display-Info "Found $envSpecificConfigFile in $projectSrcDirectory, swapping with $fileToReplace..."
                Move-Item -path $fileToReplace.FullName -destination ($fileToReplace.FullName + ".psakeTemp") -force
                Copy-Item -path $envSpecificConfigFile.FullName -destination $fileToReplace.FullName -force
            }
        }
    }
}

task ResetEnvironment {

    # Find any file ending wih .psakeTemp (backup made by SetConfigFilesForEnv task), 
    # rename the file to strip off the .psakeTemp extension, restoring the original file.

    Display-Info "Resetting config files"
	
    foreach($tempConfigFile in Get-ChildItem $src_dir -recurse -Filter *.psakeTemp) {
        Display-Info ("Resetting " + $tempConfigFile.Name + " in " + $tempConfigFile.Directory.FullName + " to " + $tempConfigFile.BaseName)
        Move-Item -path $tempConfigFile.FullName -destination ($tempConfigFile.Directory.FullName + "\" + $tempConfigFile.BaseName) -force
    }
}

task SetBuildConfiguration {
	
	if($environment -eq "live" -Or $environment -eq "staging") {
		$Script:build_configuration = "release"
	}
	else {
		$Script:build_configuration = "debug"
	}

    #Note: this is a workaround for this bug: http://connect.microsoft.com/VisualStudio/feedback/details/109232/msbuild-msbuildextensionspath-returns-invalid-path-on-x64
    #if(!($ENV:Processor_Architecture -eq "x86")) {
	#	Display-Info "In a 64 environment, forcing use of 32-bit MSBuild"
	#	$Script:msbuild_location = "C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe"
	#}
	#else {
	#	Display-Info "In a 32 environment"
	#}
}

task Clean {
    Display-Info "Cleaning solution and build folders"
	if(!($ENV:Processor_Architecture -eq "x86")) {
		&"C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe" $sln_file /t:clean /verbosity:$verbosity
	}
	else {
		msbuild $sln_file /t:clean /verbosity:$verbosity
	}
    
    Nuke-Directory $build_dir
}

task SetVersionNumber {
	$svnRevision = ([xml](svn info $base_dir --xml)).info.entry.revision
	Display-Info "Retrieved current SVN revision: $svnRevision"
	$Script:version = "$versionMajor.$versionMinor.$svnRevision"
	Display-Info "Assembly version is $Script:version"
}

task GenerateAssemblyInfo -depends SetVersionNumber { 
	Display-Info "Generating assembly info files"

	foreach($project in $projects_needing_assembly_info) {
	
		$assembly_info_file = "$base_dir\src\$project\Properties\AssemblyInfo.cs"
		Generate-Assembly-Info `
			-file $assembly_info_file `
			-title "$project $version" `
			-description "" `
			-company "Perfect Image" `
			-product "$project $version" `
			-version $Script:version `
			-clsCompliant $clsCompliant
	}
} 

# Note: Build task should -ContinueOnError so that ResetEnvironment still gets executed if the build fails
task Build -ContinueOnError -depends SetBuildConfiguration, Clean, GenerateAssemblyInfo {

    Display-Info "Building $sln_file using $msbuild_location for $environment environment, verbosity $verbosity"
    if(!($ENV:Processor_Architecture -eq "x86")) {
		&"C:\Windows\Microsoft.NET\Framework\v3.5\MSBuild.exe" "/property:OutDir=$build_dir\" "/property:Configuration=$build_configuration" /property:WarningLevel=4 /verbosity:$verbosity $sln_file
	}
	else {
		msbuild "/property:OutDir=$build_dir\" "/property:Configuration=$build_configuration" /property:WarningLevel=4 /verbosity:$verbosity $sln_file
	}

}

task Publish -depends SetBuildConfiguration {
    Display-Info "Publishing..."
	
	$environment_specific_publish_dir = "$publish_dir\$environment"
	Nuke-Directory $environment_specific_publish_dir
	
	foreach($exe_to_publish in $exes_to_publish) {
		Display-Info "Publishing exe $exe_to_publish"
		msbuild "/property:OutDir=$environment_specific_publish_dir\$exe_to_publish\,Configuration=$build_configuration" /verbosity:$verbosity "$src_dir\$exe_to_publish\$exe_to_publish.csproj"
	}
	
	if(Test-Path $built_websites_dir) { #If the '_PublishedWebsites' build directory exists 
		Display-Info "Publishing website to $environment_specific_publish_dir..."
		
        if(![string]::IsNullOrEmpty($publish_file_exclusions)) {
            Get-ChildItem $built_websites_dir -Recurse -Exclude $publish_file_exclusions | Copy-Item -Destination {Join-Path $environment_specific_publish_dir $_.FullName.Substring($built_websites_dir.length)}
        } 
        else {        
    		foreach($directory in Get-ChildItem $built_websites_dir) {                
    			Copy-Item $built_websites_dir\$directory $environment_specific_publish_dir -recurse
    		}
        }
        
        foreach($directory_to_remove in $publish_directory_exclusions) {
            if(Test-Path $environment_specific_publish_dir\$directory_to_remove){
                Remove-Item $environment_specific_publish_dir\$directory_to_remove -Recurse
            }
        } 
	}
}

task ConsolidatePublish {
	if ($projects_to_consolidate) {
		Display-Info "Consolidating publish files"
		foreach ($project_to_consolidate in $projects_to_consolidate.split(' ')) {
			foreach ($subfolder in Get-ChildItem $publish_dir\$environment\$project_to_consolidate) {
				Copy-Item -path $publish_dir\$environment\$project_to_consolidate\$subfolder -destination $publish_dir\$environment\$project_name -recurse -force
			}
			
			Remove-Item $publish_dir\$environment\$project_to_consolidate -recurse
		}
	}
}

task MigrateDatabase {
    Display-Info "Migrating database..."
    
    $subsonicSettingsFile = "$src_dir\$project_name.Migrations\app.config.$environment"
    $subsonicMigrationDir = "$src_dir\$project_name.Migrations\Migrations"
    
    If((Test-Path $subsonicSettingsFile) -and (Test-Path $subsonicMigrationDir)) {
        
        Display-Info "Using settings file $subsonicSettingsFile and migrations directory $subsonicMigrationDir"
        
        &"$subsonic_exe" migrate `
            /config "$subsonicSettingsFile" `
            /migrationdirectory "$subsonicMigrationDir" `

    }
    else {
        Display-Warning "Didn't migrate database, couldn't find settings file $subsonicSettingsFile or migrations directory $subsonicMigrationDir"
    }
}

task Minify {
    Display-Info "Minifying"
    #Packer.net usage: Packer [-?|-h] [-o <filename>] [-m <packer | jsmin | cssmin | combine>] <file1> <file2> ...
    $contentFiles = Get-ChildItem $built_main_website_content_dir -recurse
    $javascriptFiles = $contentFiles | where{$_.extension -eq ".js"}
    $cssFiles = $contentFiles | where{$_.extension -eq ".css"}

    foreach($jsFile in $javascriptFiles) {
        $jsFiletemp = $jsFile.FullName + ".temp"
        &"$microsoft_ajax_minifier" $jsFile.FullName -o $jsFiletemp
        Move-Item -path $jsFiletemp -destination $jsFile.FullName -force
    }
    
    foreach($cssFile in $cssFiles) {
        $cssFiletemp = $cssFile.FullName + ".temp"
        &"$packer_dot_net" -o $cssFiletemp -m cssmin $cssFile.FullName
        Move-Item -path $cssFiletemp -destination $cssFile.FullName -force
    }
}

task Deploy -depends SetBuildConfiguration  {
    Display-Info "Deploying..."
    
    $environment_specific_publish_dir = "$publish_dir\$environment"
    
    foreach($deploymentTargetKey in $deployment_targets.keys) {
        $deployLocation = $deployment_targets[$deploymentTargetKey][$environment]
        Display-Info "Deploying $deploymentTargetKey to $deployLocation"
        Copy-Item "$environment_specific_publish_dir\$deploymentTargetKey\*" $deployLocation -recurse -force
    }
}

task MigrateAndDeploy -depends SetBuildConfiguration, MigrateDatabase, Deploy  {
}

task CCNetDeploy -depends FullBuildAndPublish {    
    $environment_specific_publish_dir = "$publish_dir\$environment"
    
    foreach($deploymentTargetKey in $deployment_targets.keys) {
        $deployLocation = $deployment_targets[$deploymentTargetKey][$environment]
        Display-Info "Deploy location: $deployLocation"
        if((Test-Path $deployLocation)) {
            Remove-Item $deployLocation -recurse
        }

        New-Item $deployLocation -type directory
        
        Display-Info "Deploying $deploymentTargetKey to $deployLocation"        
        
        Copy-Item "$environment_specific_publish_dir\$deploymentTargetKey\*" $deployLocation -recurse -force
        Display-Info "Deploying $deploymentTargetKey to $deployLocation"
    }
}

task RunMSpecTestsWithNcover {

    Display-Info "Running MSPec on $test_assembly_paths"
    Display-Info "NCover monitoring $ncover_monitored_assemby_names"
    
    if($ENV:Processor_Architecture.CompareTo("x86")) { 
        Write-Host "In a 64 environment so forcing ncover to run under WOW64 (x86 emulation)"
        Start-Process "$corflags_exe" -Wait -ArgumentList "$ncover_exe /32BIT+"
        Start-Process "$corflags_exe" -Wait -ArgumentList "$mspec_exe /32BIT+"
    }

    try {        
        exec {
            &"$ncover_exe" `
                //reg `
                //w "$build_dir" `
                //x "$logs_dir\ncover.xml" `
                //l "$logs_dir\ncover.log" `
                //h "$logs_dir\ncover.html" `
                //a "$ncover_monitored_assemby_names" `
                //ea "$ncover_exclusion_attributes" `
                "$mspec_exe" $test_assembly_paths --silent -t --xml "$logs_dir\mspec.xml" --html "$logs_dir\Specs.html" 
        } 
    }
    catch{        
        foreach($tempConfigFile in Get-ChildItem $src_dir -recurse -Filter *.psakeTemp) {
            Display-Info ("Resetting " + $tempConfigFile.Name + " in " + $tempConfigFile.Directory.FullName + " to " + $tempConfigFile.BaseName)
            Move-Item -path $tempConfigFile.FullName -destination ($tempConfigFile.Directory.FullName + "\" + $tempConfigFile.BaseName) -force
        }
        $errorIndex = $error.Add('NCover failed when running specs')
        Display-Warning 'Tests Failed'
        
        exit(1)
    }
}

task RunNcoverExplorer {

    Display-Info "Running NCoverExplorer against $logs_dir\ncover.xml"
    
    &"$ncover_explorer_exe" "$logs_dir\ncover.xml" `
    /project:$project_name `
    /report:ModuleNamespaceSummary `
    /xml:"$logs_dir\ncoverexplorer.xml" `
    /html:"$logs_dir\ncoverexplorer.html" `
    /excluded:true `
    /failMinimum:false `
    /failCombinedMinimum:false `
    /minCoverage:80
}

task RunFxCop {
    
    Display-Info "Running FxCop using $src_dir\Report.FxCop"
    
    &"$fxcop_exe" `
        /forceoutput `
        /out:"$logs_dir\fxcop.xml" `
        /p:"$src_dir\Report.FxCop"
}

task RunStyleCop {
    #Note: Not working yet (no idea how to run this from command line - there is no exe?!)
    #&"$tools_dir\StyleCop\Microsoft.StyleCop"
}

task RunGendarme {

    Display-Info "Running Gendarme against $gendarme_monitored_assembly_names"
    
    &"$gendarme_exe" `
        --xml "$logs_dir\gendarme-result.xml" `
        "$gendarme_monitored_assembly_names"
}

task RunSourceMonitor {

    Display-Info "Running SourceMonitor"
    
    $sourceMonitorCommandFile = ("$logs_dir\sm_" + $project_name + "_cmd.xml")
    $sourceMonitorProjectFile = ("$logs_dir\sm_" + $project_name + "_cmd.smp")
    
    # Note: Encoding UTF-8 is important!
"<?xml version=""1.0"" encoding=""UTF-8"" ?>
<sourcemonitor_commands>
	<write_log>true</write_log>
	<command>
		<project_file>" + $sourceMonitorProjectFile + "</project_file>
		<project_language>CSharp</project_language>
		<source_directory>" + $src_dir + "</source_directory>
		<include_subdirectories>true</include_subdirectories>
		<checkpoint_name>$version</checkpoint_name>
		<export>
			<export_file>$logs_dir\sm_summary.xml</export_file>
			<export_type>1</export_type>
		</export>
	</command>
	<command>
		<project_file>" + $sourceMonitorProjectFile + "</project_file>
		<checkpoint_name>$version</checkpoint_name>
		<export>
			<export_file>$logs_dir\sm_details.xml</export_file>
			<export_type>2</export_type>
		</export>
	</command>
</sourcemonitor_commands>" | Out-File -Encoding "UTF8" -FilePath $sourceMonitorCommandFile

    #Note: Pipelining to out-null makes powershell wait until execution has finished
    &"$tools_dir\sourcemonitor\sourcemonitor.exe" /C $sourceMonitorCommandFile | Out-Null  
    
    remove-item -force $sourceMonitorCommandFile -ErrorAction SilentlyContinue
    remove-item -force $sourceMonitorProjectFile -ErrorAction SilentlyContinue
    TransformXmlWithXsl "$logs_dir\sm_details.xml" "$tools_dir\SourceMonitor\SourceMonitorSummaryGeneration.xsl" "$logs_dir\sm_top15.xml"
}

#MSPEC Usage: mspec-runner.exe [options] <assemblies>
    #   Options:
    #     -i, --include     Executes all specifications in contexts with these comma delimited tags. Ex. -i "foo,bar,foo_bar"
    #     -x, --exclude     Exclude specifications in contexts with these comma delimited tags. Ex. -x "foo,bar,foo_bar"
    #     -t, --timeinfo    Shows time-related information in HTML output
    #     -s, --silent      Suppress console output
    #     --teamcity        Reporting for TeamCity CI integration.
    #     --html <PATH>     Outputs an HTML file(s) to path, one-per-assembly w/ index.html (if directory, otherwise all are in one file)
    #     --xml <PATH>      Outputs an XML file(s) to path
    #     -h, --help        Shows this help message
    #   Usage: mspec-runner.exe [options] <assemblies>

#NCOVER USAGE
    #   NOTE: Any command line parameters that do not start with '//'
    #                are passed to the profiled application on its command line.
    #   
    #   //a    List of assemblies to profile separated by semi-colons
    #           i.e. "MyAssembly1;MyAssembly2"
    #   //w    Working directory for profiled application
    #   //ea   List of attributes marking classes or methods to exclude from coverage
    #   
    #   //reg  Register profiler temporarily for user. (helps with xcopy deployment)
    #   //l    Specify profiler log file
    #   //x    Specify coverage output file
    #   //h    Specify HTML report output path
    #   //pm   Specify name of process to profile (i.e. myapp.exe)
    #   
    #   //s    Save settings to a file (defaults: NCover.Settings)
    #   //r    Use settings file, overriding other settings (default: NCover.Settings
    #   
    #   //q    No logging (quiet)
    #   //v    Enable verbose logging (show instrumented code)

# NCOVER USAGE
    # /c[config]:       Path to an alternative settings file.
    # /cs[configSave]: Path to save a settings file to.
    # /h[html]:        Generate an html report with specified filename.
    # /x[xml]:         Generate an xml report with specified filename.
    # /r[report]:      Type of report to produce (default=None):
    #                   None
    #                   ModuleSummary
    #                   ModuleNamespaceSummary
    #                   ModuleClassSummary
    #                   ModuleClassFunctionSummary
    # /s[save]:        Specify the filename for the merged coverage xml.
    # /e[excluded]:    Whether to show excluded nodes in report footer.
    # /p[project]:     Name of the project to appear in the report.
    # /m[minCoverage]: Specifies the minimum coverage %
    # /f[failMinimum]: Fail build if any assembly coverage < minCoverage.
    # /fc[failCombinedMinimum]:  Fail build if total coverage < minCoverage.
    # /q[quiet]:       Minimise the console message output
    
#GENDARME USAGE: gendarme [--config file] [--set ruleset] [--{log|xml|html} file] assemblies
    #Where
    #  --config file         Specify the configuration file. Default is 'rules.xml'.
    #  --set ruleset         Specify the set of rules to verify. Default is '*'.
    #  --log file            Save the text output to the specified file.
    #  --xml file            Save the output, as XML, to the specified file.
    #  --html file           Save the output, as HTML, to the specified file.
    #  --ignore file         Do not report defects specified inside the file.
    #  --limit N             Stop reporting after N defects are found.
    #  --severity [all | [[audit | low | medium | high | critical][+|-]]],...
    #                        Filter defects for the specified severity levels.
    #                        Default is 'medium+'
    #  --confidence [all | [[low | normal | high | total][+|-]],...
    #                        Filter defects for the specified confidence levels.
    #                        Default is 'normal+'
    # --quiet                Display minimal output (results) from the runner.
    #  --v                   Enable debugging output (can be used multiple times).
    #  assemblies            Specify the assemblies to verify.
    #
    
#FXCOP USAGE
    #/file:<file/directory>  [Short form: /f:<file/directory>]
    #/rule:<[+|-]file / directory >  [Short form: /r:<[+|-]file / directory >]
    #/ruleid:<[+|-]Category#CheckId>  [Short form: /rid:<[+|-]Category#CheckId>]
    #/out:<file>  [Short form: /o:<file>]
    #/outxsl:<file>  [Short form: /oxsl:<file>]
    #/applyoutxsl  [Short form: /axsl]
    #/project:<file>  [Short form: /p:<file>]
    #/platform:<directory>  [Short form: /plat:<directory>]
    #/directory:<directory>  [Short form: /d:<directory>]
    #/types:<type list>  [Short form: /t:<type list>]
    #/import:<file/directory>  [Short form: /i:<file/directory>]
    #/summary  [Short form: /s]
    #/verbose  [Short form: /v]
    #/update  [Short form: /u]
    #/console  [Short form: /c]
    #/consolexsl:<file>  [Short form: /cxsl:<file>]
    #/forceoutput  [Short form: /fo]
    #/dictionary:<file>  [Short form: /dic:<file>]
    #/quiet  [Short form: /q]
    #/consolexsl.
    #/ignoreinvalidtargets  [Short form: /iit]
    #/aspnet  [Short form: /asp]
    #/searchgac  [Short form: /gac]
    #/successfile  [Short form: /sf]
    #/timeout:<seconds>  [Short form: /to:<seconds>]
    #/savemessagestoreport:<Active|Excluded|Absent (default: Active)>
    #/ignoregeneratedcode  [Short form: /igc]
    #/overriderulevisibilities  [Short form: /orv]
    #/culture  [Short form: /cul]
    
# MICROSOFT AJAX MINIFIER USAGE:
    # ajaxmin.exe [/?] [/S|/A] [/P[:n]|/I] [/M] [/Z] [/H[L][C]] [/J] [/K] [/L] [/C[S|L
    #]] [/D] [/3] [/V:n=v]* [/Eo:encoding] [/Ei:encoding] [/W:n] [/G:g[,g]*] [/R[:nam
    #e] resfile] [/X xmlfile] [/O destfile] [source*]

    #/?  - display usage syntax
    #/S  - silent mode; only errors appear in stderr stream
    #/A  - analyze mode
    #/M  - add code to support Macintosh Safari quirks
    #/Z  - always terminate crunched stream with a semi-colon
    #/H  - hypercrunch mode with one or more optional modifiers:
    #      add L to keep (not rename) L_ localization variables
    #      add C to combine frequently-used literals into local vars
    #/L  - don't automatically collapse 'new' operators to literals
    #/G  - list of expected globals, comma-separated
    #/Eo - encoding scheme for output file (default is ASCII)
    #/Ei - encoding scheme for all input files (default is system default)
    #/W  - warning level (Default is 0)
    #/O  - crunched output file name
    #/CL - treat catch parameter as local to function (default, IE-only behavior)
    #/CS - treat catch parameter as scoped to catch statement (non-IE behavior)
    #/P  - pretty-print output mode. optional tab size in spaces (default is 4)
    #/R  - use separate resource file for substituting localized resource literals
    #/I  - echo the input source to the output
    #/D  - remove certain debug statements from output
    #/V  - define preprocessor value
    #/J  - eval statements only used for JSON evaluation
    #/K  - make sure the generated script is safe for inline into HTML
    #/X  - use the specified XML file to determine input and output files
    #/3  - don't add IE-specific code; stick to strict standards