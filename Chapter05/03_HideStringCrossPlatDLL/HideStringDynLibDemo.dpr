program HideStringDynLibDemo;

uses
  {$IFDEF MSWINDOWS} ShareMem, {$ENDIF}
  System.StartUpCopy,
  FMX.Forms,
  ufrmHideStringMain in 'ufrmHideStringMain.pas' {frmHideStrMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHideStrMain, frmHideStrMain);
  Application.Run;
end.
