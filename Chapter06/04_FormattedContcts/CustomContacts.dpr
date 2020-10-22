program CustomContacts;



{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCustomContacts in 'ufrmCustomContacts.pas' {frmCustomBoundMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomBoundMain, frmCustomBoundMain);
  Application.Run;
end.
