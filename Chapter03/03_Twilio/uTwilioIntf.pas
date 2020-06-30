unit uTwilioIntf;

interface

uses
  System.Classes, System.SysUtils, System.Math,
  {$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}
  System.JSON,
  System.Net.HttpClient,
  uTwilioClient;

function SendTwilioSMS(AccountSID, Password, FromPhone, ToPhone, Msg, Response: PChar; ResponseLen: Integer): Integer; stdcall;

exports SendTwilioSMS;


implementation

function SendTwilioSMS(AccountSID, Password, FromPhone, ToPhone, Msg, Response: PChar; ResponseLen: Integer): Integer; stdcall;
var
  Client: TTwilioClient;
  AllParams: TStringList;
  ClientResponse: TTwilioClientResponse;
  ResponseStr: string;
begin
  ResponseStr := EmptyStr;

  Client := TTwilioClient.Create(AccountSID, Password, AccountSID);
  try
    AllParams := TStringList.Create;
    try
      AllParams.Add('From=' + FromPhone);
      AllParams.Add('To=' + ToPhone);
      AllParams.Add('Body=' + Msg);

      // POST to the Messages resource
      ClientResponse := Client.Post('Messages', AllParams);
      if ClientResponse.Success then
        ResponseStr := 'SUCCESS: ' + ClientResponse.ResponseData.GetValue<string>('sid')
      else if ClientResponse.ResponseData <> nil then
        ResponseStr := ClientResponse.ResponseData.ToString
      else
        ResponseStr := 'HTTP status: ' + ClientResponse.HTTPResponse.StatusCode.ToString;
    finally
      AllParams.Free;
    end;
  finally
    Client.Free;
  end;

  Result := Min(ResponseLen, Length(ResponseStr));
  if (Response <> nil) and (Result > 0) then
    StrPCopy(Response, ResponseStr);
end;

end.
