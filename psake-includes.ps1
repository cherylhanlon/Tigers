function Nuke-Directory
{ <# 
.SYNOPSIS 
    Silently deletes the directory and all children without prompt, then recreates the direcotry empty
.DESCRIPTION 
.NOTES 
.LINK 
#>
param([string]$dirToNuke = $(throw "dir to nuke is a required parameter."))
    
    remove-item -force -recurse $dirToNuke -ErrorAction SilentlyContinue | Out-Null
    new-item $dirToNuke -itemType directory -force | Out-Null
}

function Nuke-Directory-Contents
{ <# 
.SYNOPSIS 
    Silently deletes all directory children without prompt
.DESCRIPTION 
.NOTES 
.LINK 
#>
param([string]$dirToNuke = $(throw "dir to nuke is a required parameter."))
    
    remove-item -force -recurse $dirToNuke\* -Exclude .svn -ErrorAction SilentlyContinue | Out-Null
    new-item $dirToNuke -itemType directory -force | Out-Null
}

function Generate-Assembly-Info
{
param(
	[string]$clsCompliant = "true",
	[string]$title, 
	[string]$description, 
	[string]$company, 
	[string]$product, 
	[string]$copyright, 
	[string]$version,
	[string]$file = $(throw "file is a required parameter.")
)
 
  $asmInfo = "using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
 
[assembly: CLSCompliantAttribute($clsCompliant )]
[assembly: ComVisibleAttribute(false)]
[assembly: AssemblyTitleAttribute(""$title"")]
[assembly: AssemblyDescriptionAttribute(""$description"")]
[assembly: AssemblyCompanyAttribute(""$company"")]
[assembly: AssemblyProductAttribute(""$product"")]
[assembly: AssemblyCopyrightAttribute(""$copyright"")]
[assembly: AssemblyVersionAttribute(""$version"")]
[assembly: AssemblyInformationalVersionAttribute(""$version"")]
[assembly: AssemblyFileVersionAttribute(""$version"")]
[assembly: AssemblyDelaySignAttribute(false)]
"
 
	$dir = [System.IO.Path]::GetDirectoryName($file)
	if ([System.IO.Directory]::Exists($dir) -eq $false)
	{
		Write-Host "Creating directory $dir"
		[System.IO.Directory]::CreateDirectory($dir)
	}
	Write-Host "Generating assembly info file: $file"
	Write-Output $asmInfo > $file
}

function TransformXmlWithXsl
{
    param ($xml, $xsl, $output)

    if (-not $xml -or -not $xsl -or -not $output)
    {
    	Write-Host "& .\xslt.ps1 [-xml] xml-input [-xsl] xsl-input [-output] transform-output"
    	#exit;
    }

    trap [Exception]
    {
    	Write-Host $_.Exception;
    }

    $xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
    $xslt.Load($xsl);
    $xslt.Transform($xml, $output);

    Write-Host "generated" $output;
}

function Display-Info
{
    param ($message)
    Display-Message $message 'blue'
}

function Display-Warning
{
    param ($message)
    Display-Message $message 'red'
}

function Display-Message
{
    param ($message, $colour)

    Write-Host ""
    Write-Host "-----------------------------------------------" -foregroundcolor $colour
    Write-Host $message -foregroundcolor $colour
    Write-Host "-----------------------------------------------" -foregroundcolor $colour
    Write-Host ""
}