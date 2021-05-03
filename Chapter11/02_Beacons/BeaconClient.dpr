program BeaconClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmBeaconClient in 'ufrmBeaconClient.pas' {frmBeaconClient},
  uBeaconConsts in 'uBeaconConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBeaconClient, frmBeaconClient);
  Application.Run;
end.
