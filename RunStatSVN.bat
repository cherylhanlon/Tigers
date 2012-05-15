@ECHO OFF
echo "Running StatSVN"

If NOT (%1) == () svn log -v --xml > logs\svn.log

If NOT (%1) == () java -jar tools\statsvn\statsvn.jar logs\svn.log . -output-dir "e:\statsvn\%1" -exclude "**/N2/**;**/edit/**;**/*.csv;**/*.swf;**/*.flv" -include "**/src/**"

If (%1) == () echo "This is for Cruise Control and must be ran with a paramter for project location"
@ECHO ON