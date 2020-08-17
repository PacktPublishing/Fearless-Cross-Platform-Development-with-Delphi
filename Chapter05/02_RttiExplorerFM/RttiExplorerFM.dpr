program RttiExplorerFM;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmRttiExplorerMain in 'ufrmRttiExplorerMain.pas' {frmRttiMainFM};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRttiMainFM, frmRttiMainFM);
  Application.Run;
end.
