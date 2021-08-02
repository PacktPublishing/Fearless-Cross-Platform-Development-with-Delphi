unit uSimpleTest;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type
  [ResourceName('Test')]
  {$METHODINFO ON}
  TTestResource = class
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;
  {$METHODINFO OFF}

implementation

procedure TTestResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  CharList: TJSONArray;
begin
  CharList := TJSONArray.Create;
  for var a := 1 to 26 do
    CharList.Add(string(Chr(64 + a)));

  AResponse.Body.SetValue(CharList, True);
end;

procedure TTestResource.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
  Ch: Char;
begin
  LItem := ARequest.Params.Values['item'];
  Ch := LItem[1];

  if CharInSet(Ch, ['A'..'Z']) then
    AResponse.Body.SetValue(TJSONString.Create(
        Format('ASCII(%s) = %d', [Ch, Ord(Ch)])), True)
  else
    AResponse.Body.SetValue(
        TJSONString.Create('Enter a letter [A..Z]'), True);

end;

procedure Register;
begin
  RegisterResource(TypeInfo(TTestResource));
end;

initialization
  Register;
end.


