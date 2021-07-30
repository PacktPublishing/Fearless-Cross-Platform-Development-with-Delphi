program DelphiVersionsVCL;



uses
  Forms,
  uConditionalList in 'uConditionalList.pas',
  ufrmDelphiVersions in 'ufrmDelphiVersions.pas' {frmDelphiVersions},
  Vcl.Themes,
  Vcl.Styles;

begin
  Application.Initialize;
  Application.Title := 'Delphi Versions';
  Application.CreateForm(TfrmDelphiVersions, frmDelphiVersions);
  Application.Run;
end.
