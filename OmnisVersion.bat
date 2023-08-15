@echo off
echo Set fso=CreateObject("Scripting.FileSystemObject") > some.vbs
echo Set f=fso.OpenTextFile("%~1"):buf=f.Read(3):f.Close >> some.vbs
REM OpenTextFile opens any file as a binary stream; f.read(n) reads the first n bytes of that stream
REM echo wscript.echo Hex(ASCb(mid(buf,1,1))) ^& "," ^& Hex(ASCb(mid(buf,2,1))) ^& "," ^& Hex(ASCb(mid(buf,3,1))) >> some.vbs
echo wscript.echo (ASCb(mid(buf,1,1))) ^& "," ^& (ASCb(mid(buf,2,1))) ^& "," ^& (ASCb(mid(buf,3,1))) >> some.vbs

for /f "tokens=1-3 delims=," %%A in ('cscript //nologo some.vbs') do (
   set byte1=0%%A
   set byte2=0%%B
   set byte3=0%%C
   )
REM Just remove the temporary vbs file.
IF EXIST some.vbs DEL /F some.vbs

REM echo %~1 First three bytes are: %byte1:~-2% %byte2:~-2% %byte3:~-2%

IF             %byte1:~-2% == 44 (
                set dialogMsg= "%~1 is a Studio 3.x library."
) ELSE IF %byte1:~-2% == 45 (
				set dialogMsg= "%~1 is a Studio 4.x library."
) ELSE IF %byte1:~-2% == 46 (
				set dialogMsg= "%~1 is a Studio 4.3.1+ library."
) ELSE IF %byte1:~-2% == 47 (
				set dialogMsg= "%~1 is a Studio 5.0.x library."
) ELSE IF %byte1:~-2% == 48 (
				set dialogMsg= "%~1 is a Studio 5.1.x library."
) ELSE IF %byte1:~-2% == 49 (
				set dialogMsg= "%~1 is a Studio 5.2.x library."
) ELSE IF %byte1:~-2% == 50 (
				set dialogMsg= "%~1 is a Studio 6.0.x library."
) ELSE IF %byte1:~-2% == 51 (
				set dialogMsg= "%~1 is a Studio 6.1.x library."
) ELSE IF %byte1:~-2% == 52 (
				set dialogMsg= "%~1 is a Studio 8.0.x library."
) ELSE IF %byte1:~-2% == 53 (
				set dialogMsg= "%~1 is a Studio 8.1.x library."
) ELSE IF %byte1:~-2% == 54 (
				set dialogMsg= "%~1 is a Studio 10.0.x library."
) ELSE IF %byte1:~-2% == 55 (
				set dialogMsg= "%~1 is a Studio 10.1.x library."
) ELSE IF %byte1:~-2% == 56 (
				set dialogMsg= "%~1  is a Studio 10.2.x library."
) ELSE IF %byte1:~-2% == 57 (
				set dialogMsg= "%~1 is a Studio 11.0.x library."
) ELSE ( set dialogMsg= "%~1 is not known." )

IF %byte3:~-2% == 01 ( set "dialogMsg= %dialogMsg% (Unicode)" )

echo %dialogMsg%

pause
