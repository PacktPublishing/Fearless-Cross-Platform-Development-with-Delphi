program MobileSales;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMobileSalesMain in 'ufrmMobileSalesMain.pas' {frmMobileSalesSQLite},
  udmSQLiteSales in 'udmSQLiteSales.pas' {dmSQLiteSales: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMobileSalesSQLite, frmMobileSalesSQLite);
  Application.CreateForm(TdmSQLiteSales, dmSQLiteSales);
  Application.Run;
end.
