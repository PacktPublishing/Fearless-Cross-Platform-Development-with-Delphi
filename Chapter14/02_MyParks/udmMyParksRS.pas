unit udmMyParksRS;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase, FireDAC.Stan.StorageJSON;

type
  [ResourceName('MyParks')]
  TMyParksResource1 = class(TDataModule)
    FDMyParksConn: TFDConnection;
    qryParkList: TFDQuery;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
    qryParkByID: TFDQuery;
    qryParkListPARK_ID: TIntegerField;
    qryParkListPARK_NAME: TStringField;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  REST.Types;

procedure TMyParksResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ParkList: TJSONArray;
begin
  ParkList := TJSONArray.Create;
  qryParkList.Open;
  while not qryParkList.Eof do begin
    var ParkItem := TJSONPair.Create(TJSONNumber.Create(qryParkListPARK_ID.AsInteger),
                                     TJSONString.Create(qryParkListPARK_NAME.AsString));
    ParkList.Add(TJSONObject.Create(ParkItem));
    qryParkList.Next;
  end;

  AResponse.Body.SetValue(ParkList, True);
  qryParkList.Close;
end;

procedure TMyParksResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
  ParkID: Integer;
  ParkStream: TMemoryStream;
begin
  LItem := ARequest.Params.Values['item'];
  if TryStrToInt(LItem, ParkID) then begin
    qryParkByID.ParamByName('id').AsInteger := ParkID;
    qryParkByID.Open;
    if qryParkByID.RecordCount = 0 then
      AResponse.Body.SetValue(TJSONString.Create('Park not found for ID: ' + LItem), True)
    else begin
      ParkStream := TMemoryStream.Create;
      qryParkByID.SaveToStream(ParkStream, sfJSON);
      AResponse.Body.SetStream(ParkStream, CONTENTTYPE_APPLICATION_JSON, True);
    end;
  end else
    AResponse.Body.SetValue(TJSONString.Create('Invalid ''ID'' parmeter: ' + LItem), True);
end;

procedure TMyParksResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
end;

procedure TMyParksResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure TMyParksResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TMyParksResource1));
end;

initialization
  Register;
end.


