unit udmParksDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
  System.Generics.Collections;

type
  TdmParksDB = class(TDataModule)
    FDParkCn: TFDConnection;
    qryParkLookup: TFDQuery;
    qryParkLookupPARK_ID: TIntegerField;
    qryParkLookupPARK_NAME: TStringField;
    qryParkLookupLONGITUDE: TFMTBCDField;
    qryParkLookupLATITUDE: TFMTBCDField;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
    qryParkList: TFDQuery;
    qryParkListPARK_ID: TIntegerField;
    qryParkListPARK_NAME: TStringField;
    qryParkListLONGITUDE: TFMTBCDField;
    qryParkListLATITUDE: TFMTBCDField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure FDParkCnBeforeConnect(Sender: TObject);
  private
    FConfigFileName: string;
  public
    property ConfigFileName: string read FConfigFileName write FConfigFileName;
    type
      TParkDataRec = record
        ParkID: Integer;
        ParkName: string;
        Longitude: Double;
        Latitude: Double;
        procedure Clear;
      end;
    function LookupParkByLocation(const ALongitude, ALatitude: Double): TParkDataRec;
  end;

var
  dmParksDB: TdmParksDB;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  IniFiles,
  uMyParksLogging;

const
  LOG_TAG = 'db';

{ TdmParksDB }

procedure TdmParksDB.DataModuleDestroy(Sender: TObject);
begin
  if FDParkCn.Connected then
    FDParkCn.Connected := False;
end;

procedure TdmParksDB.FDParkCnBeforeConnect(Sender: TObject);
const
  DBSection = 'Database';
var
  Cfg: TIniFile;
begin
  Cfg := TIniFile.Create(FConfigFileName);
  try
    FDParkCn.Params.AddPair('Server',       Cfg.ReadString(DBSection, 'Server', EmptyStr));
    FDParkCn.Params.AddPair('Port',         Cfg.ReadInteger(DBSection, 'Port', 3050).ToString);
    FDParkCn.Params.AddPair('User_Name',    Cfg.ReadString(DBSection, 'Username', 'SYSDBA'));
    FDParkCn.Params.AddPair('Password',     Cfg.ReadString(DBSection, 'Password', 'masterkey'));
    FDParkCn.Params.AddPair('Database',     Cfg.ReadString(DBSection, 'DBFile', EmptyStr));
  finally
    Cfg.Free;
  end;
end;

function TdmParksDB.LookupParkByLocation(const ALongitude, ALatitude: Double): TParkDataRec;
var
  ConfigFileName: string;
begin
  Log.Info(Format('LookupParkByLocation(%f, %f)', [ALongitude, ALatitude]), LOG_TAG);

  Result.Clear;

  try
    try
      if not FDParkCn.Connected then
        FDParkCn.Connected := True;

      qryParkLookup.Prepare;
      qryParkLookup.ParamByName('long').AsSingle := ALongitude;
      qryParkLookup.ParamByName('lat').AsSingle  := ALatitude;
      Log.Debug('opening query: ' + qryParkLookup.SQL.Text, LOG_TAG);
      qryParkLookup.Open;

      Log.Debug('query recordcount: ' + qryParkLookup.RecordCount.ToString, LOG_TAG);
      if qryParkLookup.RecordCount > 0 then begin
        Result.ParkID := qryParkLookupPARK_ID.AsInteger;
        Result.ParkName := qryParkLookupPARK_NAME.AsString;
        Result.Longitude := qryParkLookupLONGITUDE.AsFloat;
        Result.Latitude  := qryParkLookupLATITUDE.AsFloat;
      end;
    except
      on e:Exception do begin
        Log.Error('database exception: ' + e.Message, LOG_TAG);
      end;
    end;
  finally
    qryParkLookup.Close;
  end;

  Log.Info(Format('  returning ParkID=%d, ParkName=%s', [Result.ParkID, Result.ParkName]), LOG_TAG);
end;

{ TdmParksDB.TParkDataRec }

procedure TdmParksDB.TParkDataRec.Clear;
begin
  ParkID := -1;
  ParkName := EmptyStr;
  Longitude := 0;
  Latitude  := 0;
end;

initialization
  dmParksDB := TdmParksDB.Create(nil);
finalization
  dmParksDB.Free;
end.
