unit uTwilioIntf;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.Net.HttpClient,
  uTwilioClient;

function SendTwilioSMS(const AccountSID, Password, FromPhone, ToPhone, Msg: string): string;


implementation

function SendTwilioSMS(const AccountSID, Password, FromPhone, ToPhone, Msg: string): string;
var
  client: TTwilioClient;
  allParams: TStringList;
  response: TTwilioClientResponse;
begin
  client := TTwilioClient.Create(AccountSID, Password, AccountSID);
  try
    allParams := TStringList.Create;
    try
      allParams.Add('From=' + FromPhone);
      allParams.Add('To=' + ToPhone);
      allParams.Add('Body=' + Msg);

      // POST to the Messages resource
      response := client.Post('Messages', allParams);
      if response.Success then
        Result := 'SUCCESS: ' + response.ResponseData.GetValue<string>('sid')
      else if response.ResponseData <> nil then
        Result := response.ResponseData.ToString
      else
        Result := 'HTTP status: ' + response.HTTPResponse.StatusCode.ToString;
    finally
      allParams.Free;
    end;
  finally
    client.Free;
  end;
end;

end.
