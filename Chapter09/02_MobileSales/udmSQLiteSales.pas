unit udmSQLiteSales;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmSQLiteSales = class(TDataModule)
    FDConnSQLite: TFDConnection;
    tblCustomers: TFDTable;
    qrySales: TFDQuery;
    tblInvoices: TFDTable;
    tblInvoicesInvoiceId: TFDAutoIncField;
    tblInvoicesCustomerId: TIntegerField;
    tblInvoicesInvoiceDate: TDateTimeField;
    tblInvoicesBillingAddress: TWideStringField;
    tblInvoicesBillingCity: TWideStringField;
    tblInvoicesBillingState: TWideStringField;
    tblInvoicesBillingCountry: TWideStringField;
    tblInvoicesBillingPostalCode: TWideStringField;
    tblInvoicesTotal: TBCDField;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  dmSQLiteSales: TdmSQLiteSales;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmSQLiteSales.DataModuleCreate(Sender: TObject);
begin
  FDConnSQLite.Open;
  qrySales.Open;
end;

end.
