program TwilioPkgConsole;

{$APPTYPE CONSOLE}

uses
  uTwilioIntf;

const
  TwilioAccount = '<MyTwilioAccountSID>';
  TwilioPassword = '<MyTwilioAuthToken>';
  FromPhone = '<MyTwilioPhoneNumber>';
  ToPhone = '<DestinationPhone>';
var
  response: string;
begin
  {$IFDEF MSWINDOWS}
  response := SendTwilioSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Windows');
  {$ELSEIF DEFINED(MACOS)}
  response := SendTwilioSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Mac');
  {$ELSEIF DEFINED(LINUX)}
  response := SendTwilioSMS(TwilioAccount, TwilioPassword, FromPhone, ToPhone, 'Hello SMS - from Linux');
  {$ENDIF}

  Writeln('Twilio SMS Response: ' + response);

  Writeln('Press ENTER to exit.');
  Readln;
end.
