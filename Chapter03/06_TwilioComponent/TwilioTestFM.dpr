program TwilioTestFM;

uses
  {$IFDEF MSWINDOWS}
  ShareMem,
  {$ENDIF }
  System.StartUpCopy,
  FMX.Forms,
  ufrmTwilioTestFM in 'ufrmTwilioTestFM.pas' {frmTwilioTestFM};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTwilioTestFM, frmTwilioTestFM);
  Application.Run;
end.
