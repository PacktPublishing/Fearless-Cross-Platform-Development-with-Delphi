program Quadrants3D;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmQaudrants in 'ufrmQaudrants.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
