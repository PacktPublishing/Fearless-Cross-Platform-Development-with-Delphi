library MyParksISAPI;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  uwmMyParks in 'uwmMyParks.pas' {wmMyParks: TWebModule},
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule},
  uMyParksLogging in 'uMyParksLogging.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
