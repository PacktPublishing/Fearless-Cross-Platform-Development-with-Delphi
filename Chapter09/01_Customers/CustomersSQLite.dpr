program CustomersSQLite;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCustomersSQLiteMain in 'ufrmCustomersSQLiteMain.pas' {frmCustomersSQLite},
  udmCustomersSQLite in 'udmCustomersSQLite.pas' {dmCustomersSQLite: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomersSQLite, frmCustomersSQLite);
  Application.CreateForm(TdmCustomersSQLite, dmCustomersSQLite);
  Application.Run;
end.
