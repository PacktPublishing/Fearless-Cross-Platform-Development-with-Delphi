program DefaultStyledControls;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmDefaultStyledControls in 'ufrmDefaultStyledControls.pas' {frmDefaultStyledControls};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDefaultStyledControls, frmDefaultStyledControls);
  Application.Run;
end.
