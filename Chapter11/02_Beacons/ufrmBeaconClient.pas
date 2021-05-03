unit ufrmBeaconClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Beacon, System.Bluetooth,
  System.Beacon.Components, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  System.ImageList, FMX.ImgList, System.Actions, FMX.ActnList, FMX.Layouts;

type
  TfrmBeaconClient = class(TForm)
    lblBeaconAppTitle: TLabel;
    Beacon: TBeacon;
    grdpnlBeaconClient: TGridPanelLayout;
    btnStart: TButton;
    btnStop: TButton;
    actBeaconClient: TActionList;
    actBeaconStartScan: TAction;
    actBeaconStopScan: TAction;
    imlBeaconClient: TImageList;
    mmoBeaconMessages: TMemo;
    mmoBeacons: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BeaconBeaconError(const Sender: TObject; AError: TBeaconError; const ErrorMsg: string; const ABeacon: TBeaconInfo);
    procedure actBeaconStartScanExecute(Sender: TObject);
    procedure actBeaconStopScanExecute(Sender: TObject);
    procedure BeaconEnterRegion(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
    procedure BeaconBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure BeaconBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
  private
    procedure UpdateBeaconList(const ABeaconList: TBeaconList);
    procedure AddLog(const AMsg: string);
  end;

var
  frmBeaconClient: TfrmBeaconClient;

implementation

{$R *.fmx}

uses
  System.Permissions,
  System.Android.Permissions,
  uBeaconConsts;

procedure TfrmBeaconClient.FormCreate(Sender: TObject);
begin
  for var i := 0 to Beacon.MonitorizedRegions.Count - 1 do
    Beacon.MonitorizedRegions.Items[i].UUID  := FEARLESS_BEACON_UUID;

  actBeaconStartScan.Enabled := True;
end;

procedure TfrmBeaconClient.UpdateBeaconList(const ABeaconList: TBeaconList);
const
  ProximityStr: array[TBeaconProximity] of string = ('Immediate', 'Near', 'Far', 'Away');
begin
  mmoBeacons.Lines.Clear;

  for var i := 0 to Length(ABeaconList) - 1 do
    mmoBeacons.Lines.Add(Format('Beacon ID %d-%d:  RSSI = %d  Distance = %f  Proximity = %s',
                                [ABeaconList[i].Major, ABeaconList[i].Minor,
                                 ABeaconList[i].Rssi, ABeaconList[i].Distance, ProximityStr[ABeaconList[i].Proximity]]));
end;

procedure TfrmBeaconClient.AddLog(const AMsg: string);
begin
  mmoBeaconMessages.Lines.Add(AMsg);
  mmoBeaconMessages.Index := mmoBeaconMessages.Lines.Count - 1;
end;

procedure TfrmBeaconClient.actBeaconStartScanExecute(Sender: TObject);
begin
  PermissionsService.DefaultService.RequestPermissions(['android.permission.ACCESS_FINE_LOCATION'],
      procedure(const Permissions: TArray<string>; const GrantResults: TArray<TPermissionStatus>)
      begin
        if (Length(GrantResults) = 1) and (GrantResults[0] = TPermissionStatus.Granted) then
          try
            Beacon.Enabled := True;
            Beacon.StartScan;

            actBeaconStartScan.Enabled := False;
            actBeaconStopScan.Enabled := True;

            AddLog('Scanning for beacons...');
          except
            on e:Exception do
              AddLog('Problem starting scan: ' + e.Message);
          end;
      end,
      procedure(const Permissions: TArray<string>; const PostRationaleProc: TProc)
      begin
        ShowMessage('no permission to scan for beacons!');
      end);
end;

procedure TfrmBeaconClient.actBeaconStopScanExecute(Sender: TObject);
begin
  try
    Beacon.StopScan;
    Beacon.Enabled := False;

    actBeaconStartScan.Enabled := True;
    actBeaconStopScan.Enabled := False;

    mmoBeacons.Lines.Clear;
    AddLog('Scanning stopped');
  except
    on e:Exception do
      AddLog('Problem stopping scan: ' + e.Message);
  end;
end;

procedure TfrmBeaconClient.BeaconBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  UpdateBeaconList(CurrentBeaconList);
end;

procedure TfrmBeaconClient.BeaconBeaconError(const Sender: TObject;
  AError: TBeaconError; const ErrorMsg: string; const ABeacon: TBeaconInfo);
begin
  AddLog('Beacon Error: ' + ErrorMsg);
end;

procedure TfrmBeaconClient.BeaconBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  UpdateBeaconList(CurrentBeaconList);
end;

procedure TfrmBeaconClient.BeaconEnterRegion(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
begin
  AddLog(Format('Enter region for: %s, Vr. %d.%d', [GUIDToString(UUID), AMajor, AMinor]));
end;

end.
