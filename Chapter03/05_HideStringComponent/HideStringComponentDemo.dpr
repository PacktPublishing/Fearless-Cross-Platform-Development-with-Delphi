program HideStringComponentDemo;

uses
  FMX.Forms,
  ufrmHideStringMain in 'ufrmHideStringMain.pas' {frmHideStrMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHideStrMain, frmHideStrMain);
  Application.Run;
end.
