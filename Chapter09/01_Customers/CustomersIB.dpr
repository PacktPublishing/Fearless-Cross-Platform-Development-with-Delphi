program CustomersIB;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmCustomersIBMain in 'ufrmCustomersIBMain.pas' {frmCustomersIB},
  udmCustomersIB in 'udmCustomersIB.pas' {dmCustomersIB: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomersIB, frmCustomersIB);
  Application.CreateForm(TdmCustomersIB, dmCustomersIB);
  Application.Run;
end.
