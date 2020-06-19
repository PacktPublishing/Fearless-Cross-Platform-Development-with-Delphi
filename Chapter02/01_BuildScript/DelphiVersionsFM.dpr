program DelphiVersionsFM;

uses
  FMX.Forms,
  uConditionalList in 'uConditionalList.pas',
  ufrmDelphiVersionsFM in 'ufrmDelphiVersionsFM.pas' {frmDelphiVersionsFM},
  uOpenViewUrl in 'uOpenViewUrl.pas';

begin
  Application.Initialize;
  Application.CreateForm(TfrmDelphiVersionsFM, frmDelphiVersionsFM);
  Application.Run;
end.

