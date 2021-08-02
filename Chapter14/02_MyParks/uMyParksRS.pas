unit uMyParksRS;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type
  [ResourceName('MyParks')]
  {$METHODINFO ON}
  TMyParksResource = class
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
  {$METHODINFO OFF}

implementation

uses
  udmParksDB;

procedure TMyParksResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ParksArray: TJSONArray;
begin
  ParksArray := TJSONArray.Create;
  try
    dmParksDB.qryParkList.Open;
    try
      while not dmParksDB.qryParkList.Eof do begin
        //var ParkEntry: TJSONObject;
        //ParkEntry := TJSONObject.Create(

        ParksArray.Add(dmParksDB.qryParkListPARK_NAME.AsString);
        dmParksDB.qryParkList.Next;
      end;

    finally
      dmParksDB.qryParkList.Close;
    end;

    AResponse.Body.SetValue(ParksArray, True);
  finally
//    ParksArray.Free;
  end;
end;

procedure TMyParksResource.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('MyParks ' + LItem), True)
end;

procedure TMyParksResource.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
end;

procedure TMyParksResource.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure TMyParksResource.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TMyParksResource));
end;

initialization
  Register;
end.


