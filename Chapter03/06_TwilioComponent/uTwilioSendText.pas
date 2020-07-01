unit uTwilioSendText;

interface

uses
  System.SysUtils, System.Classes;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX64)]
  TTwilioSendText = class(TComponent)
  private
    FAccountSID: string;
    FPassword: string;
    FFromPhone: string;
    FToPhone: string;
    FTxtMessage: string;
  public
    function Execute: string;
  published
    property AccountSID: string read FAccountSID write FAccountSID;
    property Password: string read FPassword write FPassword;
    property FromPhone: string read FFromPhone write FFromPhone;
    property ToPhone: string read FToPhone write FToPhone;
    property TxtMessage: string read FTxtMessage write FTxtMessage;
  end;

procedure Register;

implementation

uses
  uTwilioIntf;

{ TTwilioSendText }

function TTwilioSendText.Execute: string;
begin
  Result := SendTwilioSMS(FAccountSID, FPassword, FFromPhone, FToPhone, FTxtMessage);
end;

procedure Register;
begin
  RegisterComponents('Packt Publishing', [TTwilioSendText]);
end;

end.
