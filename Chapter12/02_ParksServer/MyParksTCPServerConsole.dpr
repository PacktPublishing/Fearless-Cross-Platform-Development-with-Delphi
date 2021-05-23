program MyParksTCPServerConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes, System.Threading,
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule},
  udmTCPParksServer in 'udmTCPParksServer.pas' {dmTCPParksServer: TDataModule};

type
  TConsoleParkDisplay = class
  public
    procedure OnConnect(Sender: TObject);
    procedure OnDisconnect(Sender: TObject);
    procedure OnException(const s: string);
    procedure OnExecute(const s: string);
  end;

{ TConsoleParkDisplay }

procedure TConsoleParkDisplay.OnConnect(Sender: TObject);
begin
  Writeln('>> client connected');
end;

procedure TConsoleParkDisplay.OnDisconnect(Sender: TObject);
begin
  Writeln('<< client disconnected');
end;

procedure TConsoleParkDisplay.OnException(const s: string);
begin
  Writeln('ERROR: ' + s);
end;

procedure TConsoleParkDisplay.OnExecute(const s: string);
begin
  Writeln(s);
end;

var
  ConsoleDisplay: TConsoleParkDisplay;
begin
  try
    Writeln('Starting MyParks TCP Server on port ' + dmTCPParksServer.IdTCPMyParksServer.DefaultPort.ToString);

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

    Writeln('MyParks TCP Server quitting ');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
