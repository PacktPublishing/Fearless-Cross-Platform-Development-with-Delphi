unit ufrmTwilioTestFM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Edit, uTwilioComponent, uTwilioSendText;

type
  TTwilioSMSSendFunc = function (const AccountSID, Password, FromPhone, ToPhone, Msg: string): string; stdcall;
  TfrmTwilioTestFM = class(TForm)
    HeaderToolBar: TToolBar;
    lblToolBar: TLabel;
    GestureManager: TGestureManager;
    tabCtrlTwilioMain: TTabControl;
    tabTwilioText: TTabItem;
    tabTwilioConfig: TTabItem;
    edtTwilioAccountSID: TEdit;
    edtTwilioAccountPassword: TEdit;
    lblTwilioAccountSID: TLabel;
    lblTwilioPassword: TLabel;
    lblTwillioPhoneNumber: TLabel;
    edtTwilioPhoneNumber: TEdit;
    lblRecipientPhoneNumber: TLabel;
    edtRecipientPhoneNumber: TEdit;
    btnTwilioSendText: TButton;
    lblMessageToSend: TLabel;
    edtTwilioTextMessage: TEdit;
    edtConfigFilename: TEdit;
    TwilioSendText1: TTwilioSendText;
    lblResponse: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure btnTwilioSendTextClick(Sender: TObject);
  end;

var
  frmTwilioTestFM: TfrmTwilioTestFM;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TfrmTwilioTestFM.btnTwilioSendTextClick(Sender: TObject);
var
  rsp: string;
begin
  if Length(edtRecipientPhoneNumber.Text) > 0 then
    TwilioSendText1.ToPhone := edtRecipientPhoneNumber.Text;
  TwilioSendText1.TxtMessage := edtTwilioTextMessage.Text;
  rsp := TwilioSendText1.Execute;

  if Length(rsp) > 0 then begin
    lblResponse.Visible := True;
    lblResponse.Text := 'Response: ' + rsp;
  end;
end;

procedure TfrmTwilioTestFM.FormCreate(Sender: TObject);
begin
  tabCtrlTwilioMain.ActiveTab := tabTwilioText;
end;

procedure TfrmTwilioTestFM.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if tabCtrlTwilioMain.ActiveTab <> tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabCount-1] then
        tabCtrlTwilioMain.ActiveTab := tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if tabCtrlTwilioMain.ActiveTab <> tabCtrlTwilioMain.Tabs[0] then
        tabCtrlTwilioMain.ActiveTab := tabCtrlTwilioMain.Tabs[tabCtrlTwilioMain.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

end.
