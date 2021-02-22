program MyParks;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMyParksMain in 'ufrmMyParksMain.pas' {frmMyParksMain},
  udmParkData in 'udmParkData.pas' {dmParkData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMyParksMain, frmMyParksMain);
  Application.CreateForm(TdmParkData, dmParkData);
  Application.Run;
end.
