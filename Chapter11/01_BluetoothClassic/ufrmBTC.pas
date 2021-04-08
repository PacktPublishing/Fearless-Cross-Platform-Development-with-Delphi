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
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure actBTCDeviceRefreshExecute(Sender: TObject);
    procedure actBTCDeviceDiscoverExecute(Sender: TObject);
    procedure BluetoothDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
    procedure tabctrlBTCChange(Sender: TObject);
    procedure actBTCDeviceServicesExecute(Sender: TObject);
    procedure actBTCPairDeviceExecute(Sender: TObject);
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

uses
  System.Threading;

procedure TfrmBTC.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabctrlBTC.ActiveTab := tabBTCDevices;

  tblFoundDevices.EmptyDataSet;
  tblPairdDevices.EmptyDataSet;
  tblServices.EmptyDataSet;
end;

procedure TfrmBTC.FormActivate(Sender: TObject);
begin
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
begin
  tabctrlBTC.ActiveTab := tabBTCServices;
  lblServiceDevice.Text := EmptyStr;
  tblServices.EmptyDataSet;

  if BluetoothActive and (lvBTPaired.ItemIndex > -1) then begin
    lblServiceDevice.Text := 'Services for ' + tblPairdDevicesDeviceName.AsString;
    AniIndicatorServices.Enabled := True;
    AniIndicatorServices.Visible := True;

    TTask.Run(procedure
      begin
        LServices := FPairedDevices[lvBTPaired.ItemIndex].GetServices;
        TThread.Synchronize(nil, procedure
          begin
            for var i := 0 to LServices.Count - 1 do
              tblServices.InsertRecord([LServices[i].Name, GUIDToString(LServices[i].UUID)]);

            AniIndicatorServices.Visible := False;
            AniIndicatorServices.Enabled := False;
          end);
      end);
  end
end;

procedure TfrmBTC.actBTCPairDeviceExecute(Sender: TObject);
begin
  if BluetoothActive then
    if (lvDiscoveredDevices.ItemCount > 0) then
      FAdapter.Pair(FDiscoverDevices.Items[lvDiscoveredDevices.ItemIndex])
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
