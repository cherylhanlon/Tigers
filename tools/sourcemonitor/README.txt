***********************************************************************************************
* README.TXT
***********************************************************************************************
SourceMonitor - Freeware Version 2.3.6.1 - February 6, 2007
***********************************************************************************************
***

*** New Features:

A new language, VB.NET has been added. The following minor improvements have
been included as well:

- Sort direction arrows now appear in the headers of columns in the Project View,
  Checkpoint View, and Method View.
  
- Each language can now have a list of extensions that are excluded from the list of
  files for a new checkpoint. This was inspired by the .NET habit of splitting user
  interface classes into two files, one generated by Visual Studio and the other
  developer code. This feature allows you to exclude the code generated
  automatically by Visual Studio.
  
- Command file export enhancements:
  A new command file element, <export_all_checkpoints>, has been added to specify
  export of all checkpoints in a project. In addition, the export options can now
  be specified in command files with the new <export_option> tag. Finally, an
  element has been added to the command language to allow you to specify a
  stylesheet for the display of exported XML data.

All bugs through number 62 have been fixed.

***********************************************************************************************
***********************************************************************************************
*** Introduction:

SourceMonitor monitors source code quality and quantity. Its goal is to help you,
the programmer, become better at what you do. SourceMonitor measures simple
metrics to help you expose the state of your code, and it keeps the results
around so you can see how your project code changes over time.

No attempt has been made to make the measurements independent of coding
styles, thus the numbers are meaningful only within code that is written with a
reasonably consistent style.

This is a free program; however, it is not open source and the source code is not
available because it contains proprietary source code files from outside vendors.
Feedback of all kinds is always welcome and will receive a most appreciative reception.

Thanks in advance to anyone willing to try SourceMonitor.

***********************************************************************************************
***********************************************************************************************
*** Installation:

SourceMonitor is a Win32 program that should run on Win95, Win98, WinNT,
Win2000 and WinXP. To install it, just run the SMSetupVnnnn.exe program (where
'nnnn' is the version number) and follow the on-screen instructions.
SourceMonitor has all libraries bound in so no DLL's are required.

Included with the executable and help files are some XML files. In subdirectory
"XML-Schemas_DTDs" you will find XML Schema and DTD files for 1) the metrics
data XML files exported by SourceMonitor, and 2) the SourceMonitor batch
command XML files. In subdirectory "Samples" are sample command and XML
export files. The latter are intended to help you create command files for
execution of SourceMonitor from within a batch file, and to help you interpret
data exported by SourceMonitor in XML format. Extensions submitted by
SourceMonitor users are provided in subdirectory "Contributions".

If you program with Microsoft Visual Studio, you can add SourceMonitor to your list
of tools. You can create a tool to display the detailed metrics for the file in the
active window or a tool to open SourceMonitor's project for your current
VisualStudio project. See "Running SourceMonitor" in the SourceMonitor help file.

***********************************************************************************************
***********************************************************************************************
*** Uninstallation:

To uninstall SourceMonitor, just run the Uninstall program installed with
SourceMonitor, either from the SourceMonitor group in the StartMenu or from the
Windows Control Panel's "Add/Remove Programs" dialog.

***********************************************************************************************
***********************************************************************************************
*** Current Features:

Language coverage: C++, C, C#, VB.NET, Delphi, Java, Visual Basic (VB6), and HTML.
In general, the metrics assume that the important primitive measurement is statements,
not physical lines (though both are measured and reported). In particular, the
method and function sizes and the block depth counts sum the statements, not the
physical lines, in each. If you have many blank lines in your code, they will have
no impact on the depth counts or the method and subroutine sizes.

***********************************************************************************************
***********************************************************************************************
*** Known Bugs:

All bugs through number 62 have been fixed. Bugs are posted at:

    www.campwoodsw.com/smbugs.html.

***********************************************************************************************
***********************************************************************************************
*** Enhancements:

The following is a list of features that may appear in the next major upgrade:

1) Add support for C++.NET (Managed C++).

2) Add an export option to create graphics files for charted data, particularly
   Kiviat graphs.

3) Create a new "Project of Projects" that summarizes and manages a group of
   SourceMonitor projects.

If any of these are important to you, please send an email.

***********************************************************************************************

Thanks for trying Source Monitor!

Jim Wanner    jim@campwoodsw.com

***********************************************************************************************
End of README.TXT
***********************************************************************************************

