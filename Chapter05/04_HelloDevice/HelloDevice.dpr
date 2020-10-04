program HelloDevice;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmHelloDeviceMain in 'ufrmHelloDeviceMain.pas' {frmHello};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHello, frmHello);
  Application.Run;
end.
