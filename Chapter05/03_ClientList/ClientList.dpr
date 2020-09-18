program ClientList;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmClientListMain in 'ufrmClientListMain.pas' {MasterDetailForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMasterDetailForm, MasterDetailForm);
  Application.Run;
end.
