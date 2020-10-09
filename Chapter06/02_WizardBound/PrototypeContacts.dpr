program PrototypeContacts;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmPrototypedHires in 'ufrmPrototypedHires.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
