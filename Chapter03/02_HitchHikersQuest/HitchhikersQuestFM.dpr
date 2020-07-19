program HitchhikersQuestFM;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufmHitchhikersQuestFM in 'ufmHitchhikersQuestFM.pas' {frmHitchhikersQuest};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHitchhikersQuest, frmHitchhikersQuest);
  Application.Run;
end.
