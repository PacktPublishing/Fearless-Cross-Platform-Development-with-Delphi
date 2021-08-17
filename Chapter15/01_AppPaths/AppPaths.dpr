program AppPaths;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmAppPaths in 'ufrmAppPaths.pas' {frmAppPaths};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAppPaths, frmAppPaths);
  Application.Run;
end.
