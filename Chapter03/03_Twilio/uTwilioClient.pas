unit uTwilioClient;

interface

uses
  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient;

type
  TTwilioClientResponse = record
    Success: boolean;
    ResponseData: TJSONValue;
    HTTPResponse: IHTTPResponse;
  end;

  TTwilioClient = Class
  private
    FUserName: string;
    FPassword: string;
    FAccountSid: string;
    FHttpClient: TNetHttpClient;
    FRequest: TNetHTTPRequest;
  protected
    procedure AuthEventHandler(const Sender: TObject;
      AnAuthTarget: TAuthTargetType; const ARealm, AURL: string;
      var AUserName, APassword: string; var AbortAuth: Boolean;
      var Persistence: TAuthPersistenceType); virtual;
  public
    constructor Create(UserName: string; Password: string; AccountSid: string = ''); virtual;
    destructor Destroy; override;
    function Post(resource: string; params: TStrings; domain: string = 'api';
      version: string = '2010-04-01'; prefix: string = '/Accounts/{sid}'): TTwilioClientResponse;
end;

implementation

constructor TTwilioClient.Create(UserName: string; Password: string; AccountSid: string = '');
begin
  FUserName := UserName;
  FPassword := Password;
  if AccountSid = '' then
    FAccountSid := UserName
  else
    FAccountSid := AccountSid;

  FHttpClient := TNetHttpClient.Create(nil);
  FHttpClient.OnAuthEvent := AuthEventHandler;

  FRequest := TNetHTTPRequest.Create(nil);
  FRequest.Client := FHttpClient;
end;

destructor TTwilioClient.Destroy;
begin
  inherited;
  FRequest.Free;
  FHttpClient.Free;
end;

function TTwilioClient.Post(resource: string; params: TStrings;
  domain: string = 'api'; version: string = '2010-04-01';
  prefix: string = '/Accounts/{sid}'): TTwilioClientResponse;
var
  url: String;
  response: TTwilioClientResponse;
begin
  url := 'https://' + domain + '.twilio.com/' + version + prefix + '/' +
    resource + '.json';
  if ContainsText(url, '{sid}') then
    url := ReplaceText(url, '{sid}', FAccountSid);
  response.HTTPResponse := FRequest.Post(url, params);
  response.ResponseData := TJSONObject.ParseJSONValue(
    response.HTTPResponse.ContentAsString(TEncoding.UTF8));

  response.Success := (response.HTTPResponse.StatusCode >= 200) and
    (response.HTTPResponse.StatusCode <= 299) and (response.ResponseData <> nil);

  Result := response;
end;

procedure TTwilioClient.AuthEventHandler(const Sender: TObject;
  AnAuthTarget: TAuthTargetType; const ARealm, AURL: string;
  var AUserName, APassword: string; var AbortAuth: Boolean;
  var Persistence: TAuthPersistenceType);
begin
  if AnAuthTarget = TAuthTargetType.Server then begin
    AUserName := FUserName;
    APassword := FPassword;
  end;
end;

end.
