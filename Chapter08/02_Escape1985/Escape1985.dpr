program Escape1985;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmEscape1985Main in 'ufrmEscape1985Main.pas' {frmEscape1985};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TfrmEscape1985, frmEscape1985);
  Application.Run;
end.
