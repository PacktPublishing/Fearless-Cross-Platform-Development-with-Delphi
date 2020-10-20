program DBContacts;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmDBHires in 'ufrmDBHires.pas' {frmDBContacts};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDBContacts, frmDBContacts);
  Application.Run;
end.
