unit udmCustomersIB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TdmCustomersIB = class(TDataModule)
    FDConnIB: TFDConnection;
    tblCustomers: TFDTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCustomersIB: TdmCustomersIB;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
