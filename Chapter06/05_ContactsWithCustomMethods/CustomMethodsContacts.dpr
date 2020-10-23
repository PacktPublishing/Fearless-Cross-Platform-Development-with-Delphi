program CustomMethodsContacts;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCustomMethodsContacts in 'ufrmCustomMethodsContacts.pas' {frmCustomBoundMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomBoundMain, frmCustomBoundMain);
  Application.Run;
end.
