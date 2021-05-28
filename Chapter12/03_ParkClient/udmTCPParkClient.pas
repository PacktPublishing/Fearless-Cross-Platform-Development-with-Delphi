unit udmTCPParkClient;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdGlobal;

type
  TdmTCPParkClient = class(TDataModule)
    IdTCPMyParksClient: TIdTCPClient;
    procedure IdTCPMyParksClientConnected(Sender: TObject);
    procedure IdTCPMyParksClientDisconnected(Sender: TObject);
    procedure IdTCPMyParksClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  private
    FOnClientConnected: TNotifyEvent;
    FOnClientDisconnected: TNotifyEvent;
    FOnClientStatus: TGetStrProc;
  protected
    procedure DoClientConnected;
    procedure DoClientDisconnected;
    procedure DoClientStatus(const AStatus: string);
  public
    procedure Connect;
    procedure Disconnect;
    function GetParkName(const ALong, ALat: Double): string;
    property OnClientConnected: TNotifyEvent read FOnClientConnected write FOnClientConnected;
    property OnClientDisconnected: TNotifyEvent read FOnClientDisconnected write FOnClientDisconnected;
    property OnClientStatus: TGetStrProc read FOnClientStatus write FOnClientStatus;
  end;

var
  dmTCPParkClient: TdmTCPParkClient;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmTCPParkClient.Connect;
begin
  IdTCPMyParksClient.Connect;
end;

procedure TdmTCPParkClient.Disconnect;
begin
  IdTCPMyParksClient.Disconnect;
end;

procedure TdmTCPParkClient.IdTCPMyParksClientConnected(Sender: TObject);
begin
  DoClientConnected;
end;

procedure TdmTCPParkClient.IdTCPMyParksClientDisconnected(Sender: TObject);
begin
  DoClientDisconnected;
end;

procedure TdmTCPParkClient.IdTCPMyParksClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  DoClientStatus(AStatusText);
end;

procedure TdmTCPParkClient.DoClientConnected;
begin
  if Assigned(FOnClientConnected) then
    FOnClientConnected(Self);
end;

procedure TdmTCPParkClient.DoClientDisconnected;
begin
  if Assigned(FOnClientDisconnected) then
    FOnClientDisconnected(Self);
end;

procedure TdmTCPParkClient.DoClientStatus(const AStatus: string);
begin
  if Assigned(FOnClientStatus) then
    FOnClientStatus(AStatus);
end;

function TdmTCPParkClient.GetParkName(const ALong, ALat: Double): string;
begin
  IdTCPMyParksClient.IOHandler.WriteLn(Format('longitude=%1.4f,latitude=%1.4f', [ALong, ALat]));
  Result := IdTCPMyParksClient.IOHandler.ReadLn;
end;

initialization
  dmTCPParkClient := TdmTCPParkClient.Create(nil);
finalization
  dmTCPParkClient.Free;
end.
