program MyParksGUIWebServer;
{$APPTYPE GUI}

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ufrmMyParksWebServerMain in 'ufrmMyParksWebServerMain.pas' {frmMyParksGUIWebServer},
  uwmMyParks in 'uwmMyParks.pas' {wmMyParks: TWebModule},
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule},
  uMyParksLogging in 'uMyParksLogging.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmMyParksGUIWebServer, frmMyParksGUIWebServer);
  Application.Run;
end.
