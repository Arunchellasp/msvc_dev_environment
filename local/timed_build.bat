@echo off
ctime -begin "%_config_%\ctime.ctm"
call build.bat %* 
ctime -end "%_config_%\ctime.ctm" %ERRORLEVEL%
