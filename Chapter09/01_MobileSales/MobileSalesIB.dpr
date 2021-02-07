program MobileSalesIB;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMobileSales in 'ufrmMobileSales.pas' {frmMobileSalesIB},
  udmInterBaseSales in 'udmInterBaseSales.pas' {dmInterbaseSales: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMobileSalesIB, frmMobileSalesIB);
  Application.CreateForm(TdmInterbaseSales, dmInterbaseSales);
  Application.Run;
end.
