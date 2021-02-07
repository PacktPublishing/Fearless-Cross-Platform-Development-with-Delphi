unit udmInterBaseSales;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

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

end.
