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
    tblPairdDevicesState: TStringField;
    tblPairdDevicesBTType: TStringField;
    lvBTPaired: TListView;
    BindSourceDBPaired: TBindSourceDB;
    LinkListControlToFieldDeviceName: TLinkListControlToField;
    Bluetooth: TBluetooth;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure actBTCDeviceRefreshExecute(Sender: TObject);
  private
    var
      FPairedDevices: TBluetoothDeviceList;
  end;

var
  frmBTC: TfrmBTC;

implementation

{$R *.fmx}

procedure TfrmBTC.actBTCDeviceRefreshExecute(Sender: TObject);
const
  DEVICE_STATES: array[TBluetoothDeviceState] of string = ('None', 'Paired', 'Connected');
  DEVICE_TYPES: array[TBluetoothType] of string = ('Unknown', 'Classic', 'LE', 'Dual');
begin
  if Bluetooth.CurrentManager.Current.ConnectionState = TBluetoothConnectionState.Connected then begin
    tblPairdDevices.EmptyDataSet;
    FPairedDevices := Bluetooth.CurrentManager.Current.GetPairedDevices;

    for var i := 0 to FPairedDevices.Count - 1 do
      tblPairdDevices.InsertRecord([FPairedDevices[i].DeviceName,
                                    FPairedDevices[i].Address,
                                    'State: ' + DEVICE_STATES[FPairedDevices[i].State],
                                    'Type: ' + DEVICE_TYPES[FPairedDevices[i].BluetoothType]]);
  end;
end;

procedure TfrmBTC.FormActivate(Sender: TObject);
begin
  tblPairdDevices.EmptyDataSet;

  Bluetooth.Enabled := True;
  if Bluetooth.CurrentManager.Current.ConnectionState = TBluetoothConnectionState.Connected then begin
    lblDiscoverableName.Text := 'Device''s BT Name: ' + Bluetooth.CurrentManager.CurrentAdapter.AdapterName;
  end else
    lblDiscoverableName.Text := 'No Bluetooth device Found';
end;

procedure TfrmBTC.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabctrlBTC.ActiveTab := tabBTCDevices;
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
