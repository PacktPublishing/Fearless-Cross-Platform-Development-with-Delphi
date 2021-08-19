unit udmMyParkData;

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
  {$TypeInfo ON}
  [ResourceName('MyParksData')]
  TdmMyParksData = class(TDataModule)
    FDParkCn: TFDConnection;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
    qryMyParksData: TFDQuery;
    [ResourceSuffix('list', '/')]
    [ResourceSuffix('get', '/{PARK_ID}')]
    EMSDataSetResource: TEMSDataSetResource;
    procedure FDParkCnBeforeConnect(Sender: TObject);
  private
    procedure LoadDBSettings(const ConfigFilename: string);
  end;

  [ResourceName('Debug')]
  TDebugResource = class
  published
    [EndpointName('GetItem')]
    [ResourceSuffix('{itemname}')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  private
    function GetSetting(const SettingName: string): string;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  Windows, Vcl.Dialogs, IniFiles;

procedure Register;
begin
  RegisterResource(TypeInfo(TdmMyParksData));
  RegisterResource(TypeInfo(TDebugResource));
end;

function GetPkgName: string;
var
  PkgName: Cardinal;
  TempName: string;
begin
  PkgName := MAX_PATH;
  SetLength(TempName, PkgName);
  PkgName := GetModuleFileName(HInstance, PChar(TempName), PkgName);
  SetLength(TempName, PkgName);
  Result := TempName;
end;

function GetConfigFilename: string;
begin
  Result := ChangeFileExt(GetPkgName, '.ini');
end;


{ TdmMyParksList }


procedure TdmMyParksData.FDParkCnBeforeConnect(Sender: TObject);
begin
  LoadDBSettings(GetConfigFilename);
end;

procedure TdmMyParksData.LoadDBSettings(const ConfigFilename: string);
const
  DBSection = 'Database';
var
  Cfg: TIniFile;
begin
  Cfg := TIniFile.Create(ConfigFilename);
  try
    FDParkCn.Params.Values['Server']    := Cfg.ReadString(DBSection, 'Server', EmptyStr);
    FDParkCn.Params.Values['Port']      := Cfg.ReadInteger(DBSection, 'Port', 3050).ToString;
    FDParkCn.Params.Values['User_Name'] := Cfg.ReadString(DBSection, 'Username', 'SYSDBA');
    FDParkCn.Params.Values['Password']  := Cfg.ReadString(DBSection, 'Password', 'masterkey');
    FDParkCn.Params.Values['Database']  := Cfg.ReadString(DBSection, 'DBFile', EmptyStr);
  finally
    Cfg.Free;
  end;
end;

{ TDebugResource }

procedure TDebugResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
{ provides a debugging resource for the following endpoint suffixes:
  * /debug/modulename (returns the name of the RAD Server package filename)
  * /debug/ininame    (returns the name of the configuration filename)
  * /debug/<IniKey>   (returns the value in the INI file for the <IniKey> given; e.g. "Server")
}
var
  ItemName: string;
begin
  ItemName := ARequest.Params.Values['itemname'];
  if SameText(ItemName, 'ModuleName') then
    AResponse.Body.SetValue(TJSONString.Create(GetPkgName), True)
  else if SameText(ItemName, 'IniName') then
    AResponse.Body.SetValue(TJSONString.Create(GetConfigFilename), True)
  else
    AResponse.Body.SetValue(TJSONString.Create(GetSetting(ItemName)), True);
end;


function TDebugResource.GetSetting(const SettingName: string): string;
const
  DBSection = 'Database';
var
  Cfg: TIniFile;
  IniFilename: string;
  Value: string;
begin
  IniFilename := GetConfigFilename;
  Cfg := TIniFile.Create(IniFilename);
  try
    Value := Cfg.ReadString(DBSection, SettingName, 'not found');
    Result := Format('Reading from %s (Length %d): the value under [%s] for "%s" is: %s',
                     [IniFilename, Length(IniFilename), DBSection, SettingName, Value]);
  finally
    Cfg.Free;
  end;
end;

initialization
  Register;
end.


