library mod_MyParks;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  System.Win.ComObj,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  uMyParksLogging in 'uMyParksLogging.pas',
  uwmMyParks in 'uwmMyParks.pas' {wmMyParks: TWebModule},
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule};

{$R *.res}

// httpd.conf entries:
//
(*
   --Windows---
 LoadModule myparks_module modules/mod_MyParks.dll
   --Linux--
 LoadModule myparks_module modules/libmod_MyParks.so

 <Location /myparks>
    SetHandler myparks-handler
 </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
//   1. The TApacheModuleData variable name is changed.
//   2. The project is renamed.
//   3. The output directory is not the apache/modules directory.
//   4. The dynamic library extension depends on a platform. Use .dll on Windows and .so on Linux.
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'myparks_module';

begin
{$IFDEF MSWINDOWS}
  CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData, 'myparks_handler');
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.CreateForm(TdmParksDB, dmParksDB);
  Application.Run;
end.
