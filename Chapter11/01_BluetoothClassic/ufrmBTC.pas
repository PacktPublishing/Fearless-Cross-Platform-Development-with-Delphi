unit ufrmBTC;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, System.Bluetooth,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Bluetooth.Components, System.Actions, FMX.ActnList,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.GenData, Data.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.ObjectScope,
  System.Generics.Collections, FMX.Layouts, FMX.ListBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FireDAC.Stan.StorageBin,
  FMX.Memo.Types, FMX.Edit, FMX.ScrollBox, FMX.Memo;

type
  TBTServerThread = class(TThread)
  private
    FServerSocket: TBluetoothServerSocket;
  strict private
    FClientSocket: TBluetoothSocket;
  protected
    procedure Execute; override;
  public
    property ServerSocket: TBluetoothServerSocket read FServerSocket write FServerSocket;
    constructor Create(ACreateSuspended: Boolean);
    destructor Destroy; override;
    procedure ConnectClientDevice(ADevice: TBluetoothDevice; ServiceGUID: TGUID);
    procedure SendChatMsg(const AMsg: string);
  end;

  TfrmBTC = class(TForm)
    HeaderToolBar: TToolBar;
    lblBTC: TLabel;
    tabctrlBTC: TTabControl;
    tabBTCDiscover: TTabItem;
    tabBTCDevices: TTabItem;
    tabBTCServices: TTabItem;
    tabBTCChat: TTabItem;
    GestureManager1: TGestureManager;
    tbDevices: TToolBar;
    btnRefreshBTDevices: TButton;
    StyleBook: TStyleBook;
    aclBTC: TActionList;
    actBTCDeviceRefresh: TAction;
    BindingsList1: TBindingsList;
    tbDiscoveries: TToolBar;
    btnBTDiscoverDevices: TButton;
    lblDiscoverableName: TLabel;
    tblPairdDevices: TFDMemTable;
    tblPairdDevicesDeviceName: TStringField;
    tblPairdDevicesAddress: TStringField;
    lvBTPaired: TListView;
    BindSourceDBPaired: TBindSourceDB;
    LinkListControlToFieldDeviceName: TLinkListControlToField;
    Bluetooth: TBluetooth;
    AniIndicatorDiscover: TAniIndicator;
    actBTCDeviceDiscover: TAction;
    lvDiscoveredDevices: TListView;
    tblFoundDevices: TFDMemTable;
    tblFoundDevicesDeviceName: TStringField;
    tblFoundDevicesAddress: TStringField;
    BindSourceDBFound: TBindSourceDB;
    LinkListControlToFieldDeviceName2: TLinkListControlToField;
    tbBTCServices: TToolBar;
    lblServiceDevice: TLabel;
    lvBTCServices: TListView;
    tblServices: TFDMemTable;
    actBTCDeviceServices: TAction;
    AniIndicatorServices: TAniIndicator;
    tblServicesServiceName: TStringField;
    tblServicesServiceGUID: TStringField;
    BindSourceDBServices: TBindSourceDB;
    LinkListControlToFieldServiceName: TLinkListControlToField;
    btnGetServices: TButton;
    Button1: TButton;
    actBTCPairDevice: TAction;
    mmoConversation: TMemo;
    edtChatText: TEdit;
    Label1: TLabel;
    btnSendChatMsg: TButton;
    actSendClientChatMsg: TAction;
    Label2: TLabel;
    btnStartChat: TButton;
    actStartChatClient: TAction;
    actSendServerChatMsg: TAction;
    tmrClientChatRcvr: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure actBTCDeviceRefreshExecute(Sender: TObject);
    procedure actBTCDeviceDiscoverExecute(Sender: TObject);
    procedure BluetoothDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
    procedure tabctrlBTCChange(Sender: TObject);
    procedure actBTCDeviceServicesExecute(Sender: TObject);
    procedure actBTCPairDeviceExecute(Sender: TObject);
    procedure actStartChatClientExecute(Sender: TObject);
    procedure actSendClientChatMsgExecute(Sender: TObject);
    procedure actSendServerChatMsgExecute(Sender: TObject);
    procedure tmrClientChatRcvrTimer(Sender: TObject);
  strict private
    const
      CHAT_SERVICE_NAME = 'Classic Chat';
      CHAT_SERVICE_GUID = '{C0BD4BA2-270B-41C9-ADD7-EEF64A902EBE}';
    var
      FAdapter: TBluetoothAdapter;
      FPairedDevices: TBluetoothDeviceList;
      FDiscoverDevices: TBluetoothDeviceList;
      FChatServerThread: TBTServerThread;
      FClientSocket: TBluetoothSocket;
    function BluetoothActive: Boolean;
    function FindBTDevice(BTDeviceList: TBluetoothDeviceList; const SearchDeviceName: string): TBluetoothDevice;
    procedure StartChatService;
    procedure UpdateBTName;
    procedure KillChatService;
  public
    procedure ChatConversationAdd(const Msg: string);
  end;


var
  frmBTC: TfrmBTC;

implementation

{$R *.fmx}

uses
  System.Threading, System.StrUtils;

procedure TfrmBTC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FChatServerThread <> nil then
    KillChatService;
end;

procedure TfrmBTC.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabctrlBTC.ActiveTab := tabBTCDevices;

  tblFoundDevices.EmptyDataSet;
  tblPairdDevices.EmptyDataSet;
  tblServices.EmptyDataSet;

  FClientSocket := nil;
end;

function TfrmBTC.FindBTDevice(BTDeviceList: TBluetoothDeviceList; const SearchDeviceName: string): TBluetoothDevice;
begin
  Result := nil;
  for var i := 0 to BTDeviceList.Count - 1 do
    if SameText(BTDeviceList[i].DeviceName, SearchDeviceName) then begin
      Result := BTDeviceList[i];
      Break;
    end;
end;

procedure TfrmBTC.FormActivate(Sender: TObject);
begin
  Bluetooth.Enabled := True;
  UpdateBTName;

  StartChatService;
end;

function TfrmBTC.BluetoothActive: Boolean;
begin
  Result := Bluetooth.CurrentManager.Current.ConnectionState = TBluetoothConnectionState.Connected;
end;

procedure TfrmBTC.actBTCDeviceDiscoverExecute(Sender: TObject);
begin
  btnBTDiscoverDevices.StyleLookup := 'transparentcirclebuttonstyle';
  AniIndicatorDiscover.Visible := True;
  AniIndicatorDiscover.Enabled := True;
  actBTCDeviceDiscover.Enabled := False;
  actBTCPairDevice.Enabled := False;

  if BluetoothActive then
    Bluetooth.CurrentManager.Current.StartDiscovery(20000);
end;

procedure TfrmBTC.BluetoothDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
begin
  AniIndicatorDiscover.Visible := False;
  AniIndicatorDiscover.Enabled := False;
  btnBTDiscoverDevices.StyleLookup := 'refreshtoolbutton';
  actBTCDeviceDiscover.Enabled := True;

  tblFoundDevices.EmptyDataSet;
  FDiscoverDevices := ADeviceList;
  for var i := 0 to FDiscoverDevices.Count - 1 do
    tblFoundDevices.InsertRecord([FDiscoverDevices[i].DeviceName, FDiscoverDevices[i].Address]);

  if tblFoundDevices.RecordCount > 0 then
    actBTCPairDevice.Enabled := True;
end;

procedure TfrmBTC.ChatConversationAdd(const Msg: string);
begin
  mmoConversation.Lines.Add(Msg);
end;

procedure TfrmBTC.tabctrlBTCChange(Sender: TObject);
begin
  if tabctrlBTC.ActiveTab = tabBTCDiscover then
    UpdateBTName;
end;

procedure TfrmBTC.tmrClientChatRcvrTimer(Sender: TObject);
var
  LData: TBytes;
begin
  tmrClientChatRcvr.Enabled := False;

  LData := FClientSocket.ReceiveData;
  if Length(LData) > 0 then
    ChatConversationAdd(TEncoding.UTF8.GetString(LData));

  Application.ProcessMessages;
  tmrClientChatRcvr.Enabled := True;
end;

procedure TfrmBTC.UpdateBTName;
begin
  if BluetoothActive then begin
    FAdapter := Bluetooth.CurrentAdapter;
    lblDiscoverableName.Text := 'This device: ' + FAdapter.AdapterName;
  end else
    lblDiscoverableName.Text := 'No Bluetooth device Found';
end;

procedure TfrmBTC.actBTCDeviceRefreshExecute(Sender: TObject);
begin
  if BluetoothActive then begin
    tblPairdDevices.EmptyDataSet;
    FPairedDevices := Bluetooth.CurrentManager.Current.GetPairedDevices;

    for var i := 0 to FPairedDevices.Count - 1 do
      tblPairdDevices.InsertRecord([FPairedDevices[i].DeviceName,
                                    FPairedDevices[i].Address]);
  end;
end;

procedure TfrmBTC.actBTCDeviceServicesExecute(Sender: TObject);
var
  LServices: TBluetoothServiceList;
  LSelectedDevice: TBluetoothDevice;
begin
  tabctrlBTC.ActiveTab := tabBTCServices;
  lblServiceDevice.Text := EmptyStr;
  tblServices.EmptyDataSet;

  if BluetoothActive and (tblPairdDevices.RecordCount > 0) and (lvBTPaired.ItemIndex > -1) then begin
    LSelectedDevice := FindBTDevice(FPairedDevices, tblPairdDevicesDeviceName.AsString);
    if Assigned(LSelectedDevice) then begin
      lblServiceDevice.Text := 'Services for ' + tblPairdDevicesDeviceName.AsString;
      AniIndicatorServices.Enabled := True;
      AniIndicatorServices.Visible := True;

      TTask.Run(procedure
        begin
          LServices := LSelectedDevice.GetServices;
          TThread.Synchronize(nil, procedure
            begin
              for var i := 0 to LServices.Count - 1 do
                tblServices.InsertRecord([LServices[i].Name, GUIDToString(LServices[i].UUID)]);

              AniIndicatorServices.Visible := False;
              AniIndicatorServices.Enabled := False;
            end);
        end);
    end;
  end
end;

procedure TfrmBTC.actBTCPairDeviceExecute(Sender: TObject);
var
  LSelectedDevice: TBluetoothDevice;
begin
  if BluetoothActive then
    if (tblFoundDevices.RecordCount > 0) and (lvDiscoveredDevices.ItemIndex > -1) then begin
      LSelectedDevice := FindBTDevice(FDiscoverDevices, tblFoundDevicesDeviceName.AsString);
      if Assigned(LSelectedDevice) then
        FAdapter.Pair(LSelectedDevice);
    end;
end;

procedure TfrmBTC.actSendClientChatMsgExecute(Sender: TObject);
begin
  if BluetoothActive then
    try
      var ToSend: TBytes;
      if FClientSocket <> nil then begin
        ToSend := TEncoding.UTF8.GetBytes(edtChatText.Text);
        FClientSocket.SendData(ToSend);
        ChatConversationAdd('> ' + edtChatText.Text);
      end else
        ChatConversationAdd('[No client connected]');
    except
      on E : Exception do begin
        ChatConversationAdd(E.Message);
      end;
    end;
end;

procedure TfrmBTC.actSendServerChatMsgExecute(Sender: TObject);
begin
  if BluetoothActive and (FChatServerThread <> nil) then
    try
      FChatServerThread.SendChatMsg(edtChatText.Text);
      ChatConversationAdd('>>> ' + edtChatText.Text);
    except
      on E : Exception do begin
        ChatConversationAdd(E.Message);
      end;
    end;
end;

procedure TfrmBTC.StartChatService;
begin
  if (FChatServerThread = nil) and BluetoothActive then
    try
      FAdapter := Bluetooth.CurrentAdapter;
      FChatServerThread := TBTServerThread.Create(True);
      FChatServerThread.ServerSocket := FAdapter.CreateServerSocket(CHAT_SERVICE_NAME, StringToGUID(CHAT_SERVICE_GUID), False);
      FChatServerThread.Start;

      mmoConversation.Lines.Clear;
      ChatConversationAdd('Started chat service: ' + CHAT_SERVICE_NAME);
      ChatConversationAdd('  ' + CHAT_SERVICE_GUID);
    except
      on e:Exception do begin
        ChatConversationAdd(E.Message);
      end;
    end;
end;

procedure TfrmBTC.actStartChatClientExecute(Sender: TObject);
var
  LDevice: TBluetoothDevice;
  LServices: TBluetoothServiceList;
begin
  if BluetoothActive and (lvBTPaired.ItemIndex > -1) then begin
    LDevice := FindBTDevice(FPairedDevices, lvBTPaired.Items[lvBTPaired.ItemIndex].Text);
    if Assigned(LDevice) then begin
      LServices := LDevice.GetServices;

      tabctrlBTC.ActiveTab := tabBTCChat;
      ChatConversationAdd('Connecting to "' + CHAT_SERVICE_NAME + '" on ' + LDevice.DeviceName);

      FClientSocket := LDevice.CreateClientSocket(StringToGUID(CHAT_SERVICE_GUID), False);
      if FClientSocket <> nil then begin
        FClientSocket.Connect;
        ChatConversationAdd('Connected.');

        btnSendChatMsg.Action := actSendClientChatMsg;
        actSendClientChatMsg.Enabled := True;
        tmrClientChatRcvr.Enabled := True;
      end else
        ChatConversationAdd('Could not connect to chat service.');
    end;
  end
end;

procedure TfrmBTC.FormDeactivate(Sender: TObject);
begin
  Bluetooth.Enabled := False;
end;

procedure TfrmBTC.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if tabctrlBTC.ActiveTab <> tabctrlBTC.Tabs[tabctrlBTC.TabCount-1] then
        tabctrlBTC.ActiveTab := tabctrlBTC.Tabs[tabctrlBTC.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if tabctrlBTC.ActiveTab <> tabctrlBTC.Tabs[0] then
        tabctrlBTC.ActiveTab := tabctrlBTC.Tabs[tabctrlBTC.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

procedure TfrmBTC.KillChatService;
begin
  if FChatServerThread <> nil then begin
    if not FChatServerThread.Terminated then begin
      FChatServerThread.Terminate;
      FChatServerThread.WaitFor;
    end;
    FreeAndNil(FChatServerThread);
  end;
end;

{ TBTServerThread }

procedure TBTServerThread.ConnectClientDevice(ADevice: TBluetoothDevice; ServiceGUID: TGUID);
begin
  FClientSocket := ADevice.CreateClientSocket(ServiceGUID, False);
end;

constructor TBTServerThread.Create(ACreateSuspended: Boolean);
begin
  inherited;
  FClientSocket := nil;
end;

destructor TBTServerThread.Destroy;
begin
  FreeAndNil(FServerSocket);

  inherited;
end;

procedure TBTServerThread.Execute;
var
  Msg: string;
  LData: TBytes;
begin
  while not Terminated do
    try
      // watch for possible server connection from client
      while (not Terminated) and (FClientSocket = nil) do begin
        FClientSocket := FServerSocket.Accept(100);
        if Assigned(FClientSocket) then
          Synchronize(procedure
            begin
              frmBTC.btnSendChatMsg.Action := frmBTC.actSendServerChatMsg;
            end);
      end;

      // show chat messages from client
      while not Terminated do begin
        LData := FClientSocket.ReceiveData;
        if Length(LData) > 0 then
          Synchronize(procedure
            begin
              frmBTC.ChatConversationAdd(TEncoding.UTF8.GetString(LData));
            end);
        Sleep(100);
      end;
    except
      on E : Exception do begin
        Msg := E.Message;
        Synchronize(procedure
          begin
            frmBTC.ChatConversationAdd('Server Socket closed: ' + Msg);
          end);
      end;
    end;
end;

procedure TBTServerThread.SendChatMsg(const AMsg: string);
var
  ToSend: TBytes;
begin
  if FClientSocket <> nil then begin
    ToSend := TEncoding.UTF8.GetBytes(AMsg);
    FClientSocket.SendData(ToSend);
  end;
end;

end.
