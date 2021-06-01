program MyParks;


uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMyParksMain in 'ufrmMyParksMain.pas' {TabbedForm},
  udmParkData in 'udmParkData.pas' {dmParkData: TDataModule},
  udmTCPParkClient in 'udmTCPParkClient.pas' {dmTCPParkClient: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMyParksMain, frmMyParksMain);
  Application.CreateForm(TdmParkData, dmParkData);
  Application.CreateForm(TdmTCPParkClient, dmTCPParkClient);
  Application.Run;
end.
