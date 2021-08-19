unit udmMyParkList;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase, EMS.DataSetResource,
  FireDAC.VCLUI.Wait;

type
  [ResourceName('MyParkList')]
  TdmMyParksList = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
    qryMyParksData: TFDQuery;
    [ResourceSuffix('list', '/')]
    [ResourceSuffix('get', '/{PARK_ID}')]
    EMSDataSetResource: TEMSDataSetResource;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure Register;
begin
  RegisterResource(TypeInfo(TdmMyParksList));
end;

{ TdmMyParksList }


initialization
  Register;
end.


