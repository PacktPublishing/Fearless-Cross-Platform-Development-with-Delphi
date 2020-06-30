program TwilioConsole;
{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  {$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}
  System.JSON,
  System.Net.HttpClient;

const
  {$IFDEF MSWINDOWS}       LibName = 'TwilioSMS.dll';
  {$ELSEIF DEFINED(MACOS)} LibName = 'libTwilioSMS.dylib';
  {$ELSEIF DEFINED(LINUX)} LibName = 'libTwilioSMS.so';
  {$ENDIF}

  TwilioAccount = '<MyTwilioAccountSID>';
  TwilioPassword = '<MyTwilioAuthToken>';
  FromPhone = '<MyTwilioPhoneNumber>';
  ToPhone = '<DestinationPhone>';
const
  ResponseMaxLen = 500;
type
  TTwilioSMSSendFunc = function (AccountSID, Password, FromPhone, ToPhone, Msg, Response: PChar; ResponseLen: Integer): Integer; stdcall;
var
  TwilioLibHandle: HModule;
  SendSMS: TTwilioSMSSendFunc;
  SendMsg: string;
  ResponseStr: string;
  ResponseLen: Integer;
begin
  TwilioLibHandle := LoadLibrary(LibName);
  if TwilioLibHandle = 0 then
    Writeln('Could not load Twilio SMS library: ' + LibName)
  else begin
    @SendSMS := GetProcAddress(TwilioLibHandle, 'SendTwilioSMS');

    {$IFDEF MSWINDOWS}
    SendMsg := 'Hello SMS - from Windows';
    {$ELSEIF DEFINED(MACOS)}
    SendMsg := 'Hello SMS - from Mac';
    {$ELSEIF DEFINED(LINUX)}
    SendMsg := 'Hello SMS - from Linux';
    {$ENDIF}

    SetLength(ResponseStr, ResponseMaxLen);
    ResponseLen := SendSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, PChar(SendMsg), PChar(ResponseStr), ResponseMaxLen);
    SetLength(ResponseStr, ResponseLen);

    Writeln('Twilio SMS Response: ' + ResponseStr);
    Writeln('Press ENTER to exit.');
    Readln;
  end;
end.
