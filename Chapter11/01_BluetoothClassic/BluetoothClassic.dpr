program BluetoothClassic;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmBTC in 'ufrmBTC.pas' {frmBTC};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBTC, frmBTC);
  Application.Run;
end.
