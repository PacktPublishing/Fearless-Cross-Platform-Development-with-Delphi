program VCLApp;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmVCLApp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVCLApp, frmVCLApp);
  Application.Run;
end.
