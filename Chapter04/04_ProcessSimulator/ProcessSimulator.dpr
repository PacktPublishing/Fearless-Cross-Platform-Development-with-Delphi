program ProcessSimulator;

uses
  Vcl.Forms,
  ufrmLongProcessMain in 'ufrmLongProcessMain.pas' {frmLongProcessMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLongProcessMain, frmLongProcessMain);
  Application.Run;
end.
