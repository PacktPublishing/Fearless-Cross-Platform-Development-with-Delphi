unit udmMyParksService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TMyParksIBService = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  MyParksIBService: TMyParksIBService;

implementation

{$R *.dfm}

uses
  System.Win.Registry, udmTCPParksServer;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MyParksIBService.Controller(CtrlCode);
end;

function TMyParksIBService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMyParksIBService.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then begin
      Reg.WriteString('Description', 'Listens for Longitude and Latitude data, returns the matching park name.');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TMyParksIBService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  dmTCPParksServer.Start;
end;

procedure TMyParksIBService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  dmTCPParksServer.Stop;
end;

end.
