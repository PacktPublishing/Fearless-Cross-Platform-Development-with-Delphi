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
    qryInvoiceCustomer: TFDQuery;
    srcInvoices: TDataSource;
    qryInvoiceCustomerCustomerId: TFDAutoIncField;
    qryInvoiceCustomerFirstName: TWideStringField;
    qryInvoiceCustomerLastName: TWideStringField;
    qryInvoiceCustomerCompany: TWideStringField;
    qryInvoiceCustomerAddress: TWideStringField;
    qryInvoiceCustomerCity: TWideStringField;
    qryInvoiceCustomerState: TWideStringField;
    qryInvoiceCustomerCountry: TWideStringField;
    qryInvoiceCustomerPostalCode: TWideStringField;
    qryInvoiceCustomerPhone: TWideStringField;
    qryInvoiceCustomerFax: TWideStringField;
    qryInvoiceCustomerEmail: TWideStringField;
    qryInvoiceCustomerSupportRepId: TIntegerField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    tblCustomersCustomerId: TFDAutoIncField;
    tblCustomersFirstName: TWideStringField;
    tblCustomersLastName: TWideStringField;
    tblCustomersCompany: TWideStringField;
    tblCustomersAddress: TWideStringField;
    tblCustomersCity: TWideStringField;
    tblCustomersState: TWideStringField;
    tblCustomersCountry: TWideStringField;
    tblCustomersPostalCode: TWideStringField;
    tblCustomersPhone: TWideStringField;
    tblCustomersEmail: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnSQLiteBeforeConnect(Sender: TObject);
  end;

var
  dmSQLiteSales: TdmSQLiteSales;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  IOUtils;

procedure TdmSQLiteSales.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnSQLite.Open;
    if FDConnSQLite.Connected then begin
      tblInvoices.Open;
      qryInvoiceCustomer.Open;
      tblCustomers.Open;
    end;
  except
    on e:EFDException do
      raise EFDException.Create('Could not open database: ' + FDConnSQLite.Params.Values['Database']
                  + sLineBreak + e.Message);
  end;
end;

procedure TdmSQLiteSales.FDConnSQLiteBeforeConnect(Sender: TObject);
var
  DataPath: string;
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  DataPath := TPath.GetDocumentsPath;
  {$ELSEIF DEFINED(MSWINDOWS)}
  DataPath := TPath.Combine(TPath.GetPublicPath, 'MobileSalesSQLiteData');
  {$ELSE}
  raise EProgrammerNotFound.Create('This platform is not supported in this application');
  {$ENDIF}

  FDConnSQLite.Params.Values['Database'] := TPath.Combine(DataPath, 'chinook.db');
end;

end.
