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
  FireDAC.Comp.Client, Data.Bind.DBScope, FireDAC.Stan.StorageBin;

type
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
    FlowLayoutDiscoverable: TFlowLayout;
    lblDiscAddress: TLabel;
    AniIndicatorDiscover: TAniIndicator;
    actBTCDeviceDiscover: TAction;
    lvDiscoveredDevices: TListView;
    tblFoundDevices: TFDMemTable;
    tblFoundDevicesDeviceName: TStringField;
    tblFoundDevicesAddress: TStringField;
    BindSourceDBFound: TBindSourceDB;
    LinkListControlToFieldDeviceName2: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure actBTCDeviceRefreshExecute(Sender: TObject);
    procedure actBTCDeviceDiscoverExecute(Sender: TObject);
    procedure BluetoothDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
    procedure lvDiscoveredDevicesDblClick(Sender: TObject);
    procedure tabctrlBTCChange(Sender: TObject);
  private
    var
      FAdapter: TBluetoothAdapter;
      FPairedDevices: TBluetoothDeviceList;
      FDiscoverDevices: TBluetoothDeviceList;
    procedure UpdateBTName;
    function BluetoothActive: Boolean;
  end;

var
  frmBTC: TfrmBTC;

implementation

{$R *.fmx}

procedure TfrmBTC.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabctrlBTC.ActiveTab := tabBTCDevices;
end;

procedure TfrmBTC.FormActivate(Sender: TObject);
begin
  tblFoundDevices.EmptyDataSet;
  tblPairdDevices.EmptyDataSet;

  Bluetooth.Enabled := True;
  UpdateBTName;
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

  if BluetoothActive then
    Bluetooth.CurrentManager.Current.StartDiscovery(8000);
end;

procedure TfrmBTC.BluetoothDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
begin
  TThread.Synchronize(nil, procedure
  begin
    AniIndicatorDiscover.Visible := False;
    AniIndicatorDiscover.Enabled := False;
    btnBTDiscoverDevices.StyleLookup := 'refreshtoolbutton';
    actBTCDeviceDiscover.Enabled := True;

    tblFoundDevices.EmptyDataSet;
    FDiscoverDevices := ADeviceList;
    for var i := 0 to FDiscoverDevices.Count - 1 do
      tblFoundDevices.InsertRecord([FDiscoverDevices[i].DeviceName, FDiscoverDevices[i].Address]);
  end);
end;

procedure TfrmBTC.lvDiscoveredDevicesDblClick(Sender: TObject);
begin
  FAdapter.Pair(FDiscoverDevices[lvDiscoveredDevices.ItemIndex]);
end;

procedure TfrmBTC.tabctrlBTCChange(Sender: TObject);
begin
  if tabctrlBTC.ActiveTab = tabBTCDiscover then
    UpdateBTName;
end;

procedure TfrmBTC.UpdateBTName;
begin
  if BluetoothActive then begin
    FAdapter := Bluetooth.CurrentAdapter;
    lblDiscoverableName.Text := 'This device: ' + FAdapter.AdapterName;
    lblDiscAddress.Text := FAdapter.Address;
  end else begin
    lblDiscoverableName.Text := 'No Bluetooth device Found';
    lblDiscAddress.Text := EmptyStr;
  end;
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

end.
