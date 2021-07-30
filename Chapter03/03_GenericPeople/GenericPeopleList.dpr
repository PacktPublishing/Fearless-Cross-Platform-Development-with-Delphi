program GenericPeopleList;

uses
  Vcl.Forms,
  ufrmPeopleList in 'ufrmPeopleList.pas' {frmPeopleList};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPeopleList, frmPeopleList);
  Application.Run;
end.
