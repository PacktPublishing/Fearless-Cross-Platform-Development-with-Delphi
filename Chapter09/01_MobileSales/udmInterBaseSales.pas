unit udmInterBaseSales;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
  TdmInterbaseSales = class(TDataModule)
    FDConnectionIB: TFDConnection;
    tblSales: TFDTable;
    qrySaleCustomers: TFDQuery;
    srcSales: TDataSource;
    tblSalesPO_NUMBER: TStringField;
    tblSalesCUST_NO: TIntegerField;
    tblSalesSALES_REP: TSmallintField;
    tblSalesORDER_STATUS: TStringField;
    tblSalesORDER_DATE: TSQLTimeStampField;
    tblSalesSHIP_DATE: TSQLTimeStampField;
    tblSalesDATE_NEEDED: TSQLTimeStampField;
    tblSalesPAID: TStringField;
    tblSalesQTY_ORDERED: TIntegerField;
    tblSalesTOTAL_VALUE: TCurrencyField;
    tblSalesDISCOUNT: TSingleField;
    tblSalesITEM_TYPE: TStringField;
    tblSalesAGED: TFMTBCDField;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    tblCustomers: TFDTable;
    tblCustomersCUST_NO: TIntegerField;
    tblCustomersCUSTOMER: TStringField;
    tblCustomersCONTACT_FIRST: TStringField;
    tblCustomersCONTACT_LAST: TStringField;
    tblCustomersPHONE_NO: TStringField;
    tblCustomersADDRESS_LINE1: TStringField;
    tblCustomersADDRESS_LINE2: TStringField;
    tblCustomersCITY: TStringField;
    tblCustomersSTATE_PROVINCE: TStringField;
    tblCustomersCOUNTRY: TStringField;
    tblCustomersPOSTAL_CODE: TStringField;
    tblCustomersON_HOLD: TStringField;
    procedure FDConnectionIBBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmInterbaseSales: TdmInterbaseSales;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  IOUtils;

procedure TdmInterbaseSales.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnectionIB.Open;
    if FDConnectionIB.Connected then begin
      tblSales.Open;
      qrySaleCustomers.Open;
      tblCustomers.Open;
    end;
  except
    on e:EFDException do
      raise EFDException.Create('Could not open database: ' + FDConnectionIB.Params.Values['Database']
                  + sLineBreak + e.Message);
  end;
end;

procedure TdmInterbaseSales.FDConnectionIBBeforeConnect(Sender: TObject);
var
  DataPath: string;
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  DataPath := TPath.GetDocumentsPath;
  {$ELSEIF DEFINED(MSWINDOWS)}
  DataPath := 'C:\Users\Public\Documents\Embarcadero\Studio\21.0\Samples\Data';
  {$ELSE}
  raise EProgrammerNotFound.Create('This platform is not supported in this application');
  {$ENDIF}

  FDConnectionIB.Params.Values['Database'] := TPath.Combine(DataPath, 'EMPLOYEE.GDB');
end;

end.
