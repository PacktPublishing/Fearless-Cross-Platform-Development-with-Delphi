program MultiFormControls;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMultiFormsMain in 'ufrmMultiFormsMain.pas' {frmMultiFormsMain},
  udmStyles in 'udmStyles.pas' {dmStyles: TDataModule},
  ufrmMultiFormBlue in 'ufrmMultiFormBlue.pas' {frmMaterialPatternsBlue},
  ufrmMultiFormCoral in 'ufrmMultiFormCoral.pas' {frmMultiFormCoral},
  ufrmMultiFormPuertoRico in 'ufrmMultiFormPuertoRico.pas' {frmMultiFormPuertoRico};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMultiFormsMain, frmMultiFormsMain);
  Application.CreateForm(TdmStyles, dmStyles);
  Application.CreateForm(TfrmMaterialPatternsBlue, frmMaterialPatternsBlue);
  Application.CreateForm(TfrmMultiFormCoral, frmMultiFormCoral);
  Application.CreateForm(TfrmMultiFormPuertoRico, frmMultiFormPuertoRico);
  Application.Run;
end.
