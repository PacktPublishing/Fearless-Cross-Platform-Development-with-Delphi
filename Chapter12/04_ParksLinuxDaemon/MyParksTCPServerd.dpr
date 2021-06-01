program MyParksTCPServerd;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Posix.Unistd,
  Posix.Signal,
  Posix.SysStat,
  Posix.Syslog,
  Posix.Fcntl,
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule},
  udmTCPParksServer in 'udmTCPParksServer.pas' {dmTCPParksServer: TDataModule};

var
  Terminated: Boolean;

procedure HandleSignals(SigNum: Integer); cdecl;
begin
  case SigNum of
    SIGTERM:
      Terminated := True;
  end;
end;

procedure SpawnDaemonProcess;
var
  NewPID: Integer;
begin
  syslog(LOG_DEBUG, 'Spawning daemon process');

  // create a spawned process, returning the new Process ID
  NewPID := Fork;
  if NewPID < 0 then begin
    const ForkError = 'Error forking the process';
    syslog(LOG_ERR, ForkError);
    raise Exception.Create(ForkError);
  end;

  // successfully created; kill parent process
  if NewPID > 0 then
    Halt(0);

  if SetSID < 0 then begin
    const SessionError = 'Could not create an independent session';
    syslog(LOG_ERR, SessionError);
    raise Exception.Create(SessionError);
  end;

  // ignore child signals
  Signal(SIGCHLD, TSignalHandler(SIG_IGN));
  // handle termination
  Signal(SIGTERM, HandleSignals);

  // fork again
  NewPID := Fork;
  if NewPid > 0 then
    Halt(0);

  syslog(LOG_DEBUG, 'The parent prcoess has been killed.');
  // close file descriptors
  for var idx := sysconf(_SC_OPEN_MAX) downto 0 do
    __close(idx);

  // Route I/O connections to > dev/null
  var fid := __open('/dev/null', O_RDWR);
  dup(fid);
  dup(fid);

  // set file creation mode for any temporary files that might be created
  UMask(027);

  // set root directory
  ChDir('/');

  // start the TCP server
  dmTCPParksServer.Start;

  repeat
    Sleep(200);
  until Terminated;

  dmTCPParksServer.Stop;
end;

begin
  Terminated := False;

  // check the Parent Process ID; if > 1, we're a regular process and can proceed
  if GetPPID > 1 then
    SpawnDaemonProcess;
end.
