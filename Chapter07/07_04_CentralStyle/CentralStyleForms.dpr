program CentralStyleForms;



{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCentralStyleFormsMain in 'ufrmCentralStyleFormsMain.pas' {frmMultiFormsMain},
  ufrmCentralStyleFormOne in 'ufrmCentralStyleFormOne.pas' {frmCentralStyleFormOne},
  ufrmCentralStyleFormTwo in 'ufrmCentralStyleFormTwo.pas' {frmCentralStyleFormTwo},
  ufrmCentralStyleFormThree in 'ufrmCentralStyleFormThree.pas' {frmCentralStyleFormThree},
  uStyleMgr in 'uStyleMgr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMultiFormsMain, frmMultiFormsMain);
  Application.CreateForm(TfrmCentralStyleFormOne, frmCentralStyleFormOne);
  Application.CreateForm(TfrmCentralStyleFormTwo, frmCentralStyleFormTwo);
  Application.CreateForm(TfrmCentralStyleFormThree, frmCentralStyleFormThree);
  Application.Run;
end.
