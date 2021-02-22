unit udmParkData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmParkData = class(TDataModule)
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDConn: TFDConnection;
    tblParks: TFDTable;
    tblParksID: TFDAutoIncField;
    tblParksParkName: TWideStringField;
    tblParksLocX: TFloatField;
    tblParksLocY: TFloatField;
    tblParksMainPic: TBlobField;
    tblParksHasPlaygound: TBooleanField;
    tblParksHasRestrooms: TBooleanField;
    tblParksNotes: TWideMemoField;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  dmParkData: TdmParkData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  IOUtils;

procedure TdmParkData.DataModuleCreate(Sender: TObject);
var
  DataPath: string;
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  DataPath := TPath.GetDocumentsPath;
  {$ELSE}
  raise EProgrammerNotFound.Create('This platform is not supported in this application');
  {$ENDIF}

  FDConn.Params.Values['Database'] := TPath.Combine(DataPath, 'MyParks.db');
  FDConn.Open;

  tblParks.Open;
end;

end.
