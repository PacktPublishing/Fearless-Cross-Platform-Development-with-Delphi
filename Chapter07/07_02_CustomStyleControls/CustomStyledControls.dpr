program CustomStyledControls;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCustomStyledControls in 'ufrmCustomStyledControls.pas' {frmCustomStyledControls};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomStyledControls, frmCustomStyledControls);
  Application.Run;
end.
