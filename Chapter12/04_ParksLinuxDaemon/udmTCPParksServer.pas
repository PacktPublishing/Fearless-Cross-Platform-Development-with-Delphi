unit udmTCPParksServer;

interface

uses
  System.SysUtils, System.Classes,
  IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer;

type
  TdmTCPParksServer = class(TDataModule)
    IdTCPMyParksServer: TIdTCPServer;
    procedure IdTCPMyParksServerConnect(AContext: TIdContext);
    procedure IdTCPMyParksServerExecute(AContext: TIdContext);
    procedure IdTCPMyParksServerException(AContext: TIdContext; AException: Exception);
    procedure IdTCPMyParksServerDisconnect(AContext: TIdContext);
  private
    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    FOnException: TGetStrProc;
    FOnExecute: TGetStrProc;
    function IsRunning: Boolean;
  protected
    procedure DoOnConnect;
    procedure DoOnDisconnect;
    procedure DoOnException(const ExceptionMsg: string);
    procedure DoOnExecute(const AMessage: string);
  public
    procedure Start;
    procedure Stop;
    property Running: Boolean read IsRunning;
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
    property OnException: TGetStrProc read FOnException write FOnException;
    property OnExecute: TGetStrProc read FOnExecute write FOnExecute;
  end;

var
  dmTCPParksServer: TdmTCPParksServer;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  System.StrUtils, IdIOHandlerSocket,
  {$IFDEF LINUX}
  Posix.Syslog,
  {$ELSE}
  uMyParksLogging,
  {$ENDIF}
  udmParksDB;

{$IFNDEF LINUX}
const
  LOG_TAG = 'tcp';
{$ENDIF}

procedure TdmTCPParksServer.DoOnConnect;
begin
  {$IFDEF LINUX}
  syslog(LOG_DEBUG, 'OnConnect');
  {$ELSE}
  Log.Debug('OnConnect', LOG_TAG);
  {$ENDIF}
  if Assigned(FOnConnect) then
    FOnConnect(self);
end;

procedure TdmTCPParksServer.DoOnDisconnect;
begin
  {$IFDEF LINUX}
  syslog(LOG_DEBUG, 'OnDisconnect');
  {$ELSE}
  Log.Debug('OnDisconnect', LOG_TAG);
  {$ENDIF}
  if Assigned(FOnDisconnect) then
    FOnDisconnect(self);
end;

procedure TdmTCPParksServer.DoOnException(const ExceptionMsg: string);
begin
  {$IFDEF LINUX}
  syslog(LOG_ERR, 'OnException: ' + ExceptionMsg);
  {$ELSE}
  Log.Error('OnException: ' + ExceptionMsg, LOG_TAG);
  {$ENDIF}
  if Assigned(FOnException) then
    FOnExecute(ExceptionMsg);
end;

procedure TdmTCPParksServer.DoOnExecute(const AMessage: string);
begin
  {$IFDEF LINUX}
  syslog(LOG_DEBUG, 'OnExecute');
  {$ELSE}
  Log.Debug('OnExecute', LOG_TAG);
  {$ENDIF}
  if Assigned(FOnExecute) then
    FOnExecute('Response: ' + AMessage);
end;

procedure TdmTCPParksServer.IdTCPMyParksServerConnect(AContext: TIdContext);
begin
  DoOnConnect;
end;

procedure TdmTCPParksServer.IdTCPMyParksServerDisconnect(AContext: TIdContext);
begin
  DoOnDisconnect;
end;

procedure TdmTCPParksServer.IdTCPMyParksServerException(AContext: TIdContext; AException: Exception);
begin
  DoOnException(AException.Message);
end;

procedure TdmTCPParksServer.IdTCPMyParksServerExecute(AContext: TIdContext);
var
  ValidRequest: Boolean;
  Requests: TStringList;
  ReqLong, ReqLat: Double;
  ResponseStr: string;
begin
  {$IFDEF LINUX}
  syslog(LOG_INFO, 'Request received');
  {$ELSE}
  Log.Info('Received Request', LOG_TAG);
  {$ENDIF}

  ValidRequest := False;
  ResponseStr := EmptyStr;

  Requests := TStringList.Create;
  try
    Requests.CommaText := Trim(AContext.Connection.Socket.ReadLn);

    if Requests.Count = 2 then begin
      if TryStrToFloat(Requests.Values['longitude'], ReqLong) and
        TryStrToFloat(Requests.Values['latitude'], ReqLat) then begin
        {$IFDEF LINUX}
        syslog(LOG_DEBUG, Format('  Request parameters: longitude=%f, latitude=%f', [ReqLong, ReqLat]));
        {$ELSE}
        Log.Debug(Format('  Request parameters: longitude=%f, latitude=%f', [ReqLong, ReqLat]), LOG_TAG);
        {$ENDIF}

        var ParkInfo := dmParksDB.LookupParkByLocation(ReqLong, ReqLat);
        if ParkInfo.ParkName.Length > 0 then begin
          ResponseStr := ParkInfo.ParkName;
          {$IFDEF LINUX}
          syslog(LOG_INFO, '  Returning park name: ' + ResponseStr);
          {$ELSE}
          Log.Debug('  Returning park name: ' + ResponseStr, LOG_TAG);
          {$ENDIF}
          ValidRequest := True;
        end else begin
          ResponseStr := '<Unknown Park>';
          {$IFDEF LINUX}
          syslog(LOG_WARNING, '  Returning: ' + ResponseStr);
          {$ELSE}
          Log.Warn('  Returning: ' + ResponseStr, LOG_TAG);
          {$ENDIF}
        end;
      end;
    end;
  finally
    Requests.Free;
  end;

  if (not ValidRequest) and (ResponseStr.Length = 0) then begin
    ResponseStr := 'ERROR: Invalid request';
    {$IFDEF LINUX}
    syslog(LOG_ERR, '  Returning: ' + ResponseStr);
    {$ELSE}
    Log.Error('  Returning: ' + ResponseStr, LOG_TAG);
    {$ENDIF}
  end;

  AContext.Connection.Socket.WriteLn(ResponseStr);
  DoOnExecute(ResponseStr);
end;

function TdmTCPParksServer.IsRunning: Boolean;
begin
  Result := IdTCPMyParksServer.Active;
end;

procedure TdmTCPParksServer.Start;
begin
  {$IFDEF LINUX}
  syslog(LOG_NOTICE, 'TCP Server Starting');
  {$ELSE}
  Log.Info('START', LOG_TAG);
  {$ENDIF}
  IdTCPMyParksServer.Active := True;
end;

procedure TdmTCPParksServer.Stop;
begin
  {$IFDEF LINUX}
  syslog(LOG_NOTICE, 'TCP Server Stopping');
  {$ELSE}
  Log.Info('STOP', LOG_TAG);
  {$ENDIF}
  IdTCPMyParksServer.Active := False;
end;

initialization
  dmTCPParksServer := TdmTCPParksServer.Create(nil);
finalization
  dmTCPParksServer.Free;
end.
