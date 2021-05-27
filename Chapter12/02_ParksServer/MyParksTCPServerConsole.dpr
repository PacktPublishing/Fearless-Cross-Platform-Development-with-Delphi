program MyParksTCPServerConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  System.IOUtils,
  LoggerPro.GlobalLogger,
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule},
  udmTCPParksServer in 'udmTCPParksServer.pas' {dmTCPParksServer: TDataModule},
  uMyParksLogging in 'uMyParksLogging.pas';

type
  TConsoleParkDisplay = class
  public
    procedure OnConnect(Sender: TObject);
    procedure OnDisconnect(Sender: TObject);
    procedure OnException(const s: string);
    procedure OnExecute(const s: string);
  end;

const
  LOG_TAG = 'console';


{ TConsoleParkDisplay }

procedure TConsoleParkDisplay.OnConnect(Sender: TObject);
begin
  Log.Info('Client connected', LOG_TAG);
end;

procedure TConsoleParkDisplay.OnDisconnect(Sender: TObject);
begin
  Log.Info('Client disconnected', LOG_TAG);
end;

procedure TConsoleParkDisplay.OnException(const s: string);
begin
  Log.Error(s, LOG_TAG);
end;

procedure TConsoleParkDisplay.OnExecute(const s: string);
begin
  Log.Info(s, LOG_TAG);
end;

var
  ConsoleDisplay: TConsoleParkDisplay;
begin
  try
    Log.Info('Starting MyParks TCP Server on port ' + dmTCPParksServer.IdTCPMyParksServer.DefaultPort.ToString, LOG_TAG);

    ConsoleDisplay := TConsoleParkDisplay.Create;
    try
      dmTCPParksServer.OnConnect := ConsoleDisplay.OnConnect;
      dmTCPParksServer.OnExecute := ConsoleDisplay.OnExecute;
      dmTCPParksServer.OnException := ConsoleDisplay.OnException;
      dmTCPParksServer.OnDisconnect := ConsoleDisplay.OnDisconnect;

      dmTCPParksServer.Start;

      while dmTCPParksServer.Running do
        Sleep(100);
    finally
      ConsoleDisplay.Free;
    end;

    Log.Info('MyParks TCP Server quitting ', LOG_TAG);
  except
    on E: Exception do begin
      Log.Error(E.ClassName + ': ' + E.Message, LOG_TAG);
    end;
  end;
end.
