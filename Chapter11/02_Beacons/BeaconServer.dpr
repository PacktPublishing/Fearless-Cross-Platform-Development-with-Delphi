program BeaconServer;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmBeaconServer in 'ufrmBeaconServer.pas' {frmBeaconServer},
  uBeaconConsts in 'uBeaconConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBeaconServer, frmBeaconServer);
  Application.Run;
end.
