program Quadrants3D;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmQaudrants in 'ufrmQaudrants.pas' {frm3DQuadrants};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm3DQuadrants, frm3DQuadrants);
  Application.Run;
end.
