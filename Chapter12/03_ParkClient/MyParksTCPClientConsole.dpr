program MyParksTCPClientConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.StrUtils,
  udmTCPParkClient in 'udmTCPParkClient.pas' {dmTCPParkClient: TDataModule};

const
  BAD_NUM = 'Invalid number';
  QUIT_CMD = 'quit';
  QUERY_CMD = 'query';

function GetCoordinates(var Long, Lat: Double): string;
var
  s: string;
begin
  Result := EmptyStr;
  Writeln;

  // get longitude
  Write('Enter longitude or "quit" to end: ');
  Readln(s);

  if SameText(QUIT_CMD, s) then
    Result := s
  else
    if not TryStrToFloat(s, Long) then
      Result := BAD_NUM;

  if Result.Length = 0 then begin
    // get latitude
    Write('Enter latitude or "quit" to end: ');
    Readln(s);

    if SameText(QUIT_CMD, s) then
      Result := s
    else
      if not TryStrToFloat(s, Lat) then
        Result := BAD_NUM;
  end;

  if Result.Length = 0 then
    // both numbers valid, compose request str
    Result := QUERY_CMD;
end;

var
  cmd: string;
  done: Boolean;
  Long, Lat: Double;
begin
  try
    dmTCPParkClient.IdTCPMyParksClient.Host := '127.0.0.1';
    dmTCPParkClient.IdTCPMyParksClient.Port := 8081;
    dmTCPParkClient.Connect;

    done := False;
    repeat
      cmd := GetCoordinates(Long, Lat);
      if SameText(cmd, QUIT_CMD) then
        done := True
      else if SameText(cmd, QUERY_CMD) then
        Writeln(dmTCPParkClient.GetParkName(Long, Lat))
      else
        Writeln(cmd);
    until done;

    Writeln('Good-bye');
    dmTCPParkClient.Disconnect;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
