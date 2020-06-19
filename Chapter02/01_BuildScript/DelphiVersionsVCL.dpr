program DelphiVersionsVCL;

{$R 'DelphiVersionsVCL.res' 'DelphiVersionsVCL.rc'}

uses
  Forms,
  uConditionalList in 'uConditionalList.pas',
  ufrmDelphiVersions in 'ufrmDelphiVersions.pas' {frmDelphiVersions},
  Vcl.Themes,
  Vcl.Styles;

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('CopperDark');
  Application.Title := 'Delphi Versions';
  Application.CreateForm(TfrmDelphiVersions, frmDelphiVersions);
  Application.Run;
end.
