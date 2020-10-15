program PrototypeContacts;



{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmPrototypedHires in 'ufrmPrototypedHires.pas' {frmWizardBoundMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmWizardBoundMain, frmWizardBoundMain);
  Application.Run;
end.
