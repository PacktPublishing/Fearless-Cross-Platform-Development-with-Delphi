program RttiExplorer;

uses
  Vcl.Forms,
  ufrmRttiMain in 'ufrmRttiMain.pas' {frmRttiMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRttiMain, frmRttiMain);
  Application.Run;
end.
