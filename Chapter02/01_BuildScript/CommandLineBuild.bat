@echo off

REM -- make sure destination folders exist
if not exist .\Win32\Debug   md .\Win32\Debug
if not exist .\Win32\Release md .\Win32\Release
if not exist .\Win64\Debug   md .\Win64\Debug
if not exist .\Win64\Release md .\Win64\Release
if not exist .\OSX64\Debug   md .\OSX64\Debug
if not exist .\OSX64\Release md .\OSX64\Release

call CommandLineClean.bat

REM -- setup environment variables for this version of Delphi --
call "c:\program files (x86)\embarcadero\studio\21.0\bin\rsvars.bat"

REM -- Windows 32-bit Console app --
dcc32.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win32\Debug   -NU.\Win32\Debug   -NSSystem; -U"%BDS%\lib\Win32\debug"   -V -VN -VR DelphiVersionsConsole.dpr
dcc32.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win32\Release -NU.\Win32\Release -NSSystem; -U"%BDS%\lib\Win32\release" -V -VN -VR DelphiVersionsConsole.dpr

REM -- Windows 64-bit Console app --
dcc64.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win64\Debug   -NU.\Win64\Debug   -NSSystem; -U"%BDS%\lib\Win64\debug"   -V -VN -VR DelphiVersionsConsole.dpr
dcc64.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win64\Release -NU.\Win64\Release -NSSystem; -U"%BDS%\lib\Win64\release" -V -VN -VR DelphiVersionsConsole.dpr

REM -- VCL Resource --
cgrc.exe -c65001 -v DelphiVersionsVCL.rc -foDelphiVersionsVCL.res 

REM -- Windows 32-bit VCL app --
dcc32.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win32\Debug   -NU.\Win32\Debug   -NSSystem;Vcl;Vcl.Shell;WinAPI -R"%BDS%\lib\Win32\Release" -U"%BDS%\lib\Win32\debug"   -V -VN -VR DelphiVersionsVCL.dpr
dcc32.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win32\Release -NU.\Win32\Release -NSSystem;Vcl;Vcl.Shell;WinAPI -R"%BDS%\lib\Win32\Release" -U"%BDS%\lib\Win32\release" -V -VN -VR DelphiVersionsVCL.dpr

REM -- Windows 64-bit VCL app --
dcc64.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win64\Debug   -NU.\Win64\Debug   -NSSystem;Vcl;Vcl.Shell;WinAPI -R"%BDS%\lib\Win64\Release" -U"%BDS%\lib\Win64\debug"   -V -VN -VR DelphiVersionsVCL.dpr
dcc64.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win64\Release -NU.\Win64\Release -NSSystem;Vcl;Vcl.Shell;WinAPI -R"%BDS%\lib\Win64\Release" -U"%BDS%\lib\Win64\release" -V -VN -VR DelphiVersionsVCL.dpr

REM -- Windows 32-bit FireMonkey app --
dcc32.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win32\Debug   -R"%BDS%\lib\Win32\release" -U"%BDS%\lib\Win32\debug"   -K00400000 DelphiVersionsFM.dpr
dcc32.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win32\Release -R"%BDS%\lib\Win32\release" -U"%BDS%\lib\Win32\release" -K00400000 DelphiVersionsFM.dpr

REM -- Windows 64-bit FireMonkey app --
dcc64.exe -$O- -$W+ --no-config -B -TX.exe -DDEBUG   -E.\Win64\Debug   -R"%BDS%\lib\Win64\release" -U"%BDS%\lib\Win64\debug"   -K00400000 DelphiVersionsFM.dpr
dcc64.exe -$O+ -$W- --no-config -B -TX.exe -DRELEASE -E.\Win64\Release -R"%BDS%\lib\Win64\release" -U"%BDS%\lib\Win64\release" -K00400000 DelphiVersionsFM.dpr

REM -- Mac 64-bit FireMonkey app --
dccosx64.exe -$O- --no-config -B -DDEBUG   -E.\OSX64\Debug   -R"%BDS%\lib\OSX64\release";"%BDS%\redist\OSX64" -U"%BDS%\lib\OSX64\debug" -NO.\OSX64\Debug -NU.\OSX64\Debug -NSSystem -O"%BDS%\lib\OSX64\debug";"%BDS%\redist\OSX64" --syslibroot:"%USERPROFILE%\Documents\Embarcadero\Studio\SDKs\MacOSX10.14.sdk" DelphiVersionsFM.dpr
dccosx64.exe -$O+ --no-config -B -DRELEASE -E.\OSX64\Release -R"%BDS%\lib\OSX64\release";"%BDS%\redist\OSX64" -U"%BDS%\lib\OSX64\release" -NO.\OSX64\Release -NU.\OSX64\Release -NSSystem -O"%BDS%\lib\OSX64\release";"%BDS%\redist\OSX64" --syslibroot:"%USERPROFILE%\Documents\Embarcadero\Studio\SDKs\MacOSX10.14.sdk"  DelphiVersionsFM.dpr
