unit ufrmBeaconServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon,
  System.Bluetooth, System.Beacon.Components, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Actions, FMX.ActnList, System.ImageList, FMX.ImgList,
  FMX.Layouts, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TfrmBeaconServer = class(TForm)
    BeaconDevice: TBeaconDevice;
    lblBeaconAppTitle: TLabel;
    lblBeaconUUID: TLabel;
    lblBeaconTxPower: TLabel;
    lblBeaconIDs: TLabel;
    grdpnlButtons: TGridPanelLayout;
    btnStart: TButton;
    btnStop: TButton;
    actBeaconDevice: TActionList;
    actBeaconStart: TAction;
    actBeaconStop: TAction;
    mmoBeaconMessages: TMemo;
    imlBeaconDevice: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure actBeaconStartExecute(Sender: TObject);
    procedure actBeaconStopExecute(Sender: TObject);
  private
    const
      SERVER_SETTINGS_INI_FILENAME = 'BeaconServer.ini';
      INIKEY_IDSection = 'ID';
      ININame_IDMajor = 'Major';
      ININame_IDMinor = 'Minor';
      INIKEY_ConfigSection = 'Config';
      ININame_ConfigPowerLevel = 'PowerLevel';
    type
      TBeaconServerSettings = record
        MajorID: Integer;
        MinorID: Integer;
        PwrLevel: Integer;
      end;
    var
      FServerDataPath: string;
    procedure LoadServerSettings(var AServerSettings: TBeaconServerSettings);
    procedure SaveServerSettings(const AServerSettings: TBeaconServerSettings);

    procedure BeaconMsg(const AMsg: string);
  end;

var
  frmBeaconServer: TfrmBeaconServer;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone47in.fmx IOS}
{$R *.iPad.fmx IOS}
{$R *.iPhone55in.fmx IOS}

uses
  System.IOUtils, System.IniFiles,
  uBeaconConsts;

procedure TfrmBeaconServer.actBeaconStartExecute(Sender: TObject);
begin
  try
    BeaconDevice.Enabled := True;

    actBeaconStart.Enabled := False;
    actBeaconStop.Enabled := True;

    BeaconMsg('Beacon started at ' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));
  except
    on E: Exception do begin
      BeaconMsg('Problem starting: ' + E.Message);
      BeaconDevice.Enabled := False;
    end;
  end;
end;

procedure TfrmBeaconServer.actBeaconStopExecute(Sender: TObject);
begin
  try
    BeaconDevice.Enabled := False;

    actBeaconStart.Enabled := True;
    actBeaconStop.Enabled := False;

    BeaconMsg('Beacon stopped at ' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));
  except
    on E: Exception do begin
      BeaconMsg('Problem stopping: ' + E.Message);
      BeaconDevice.Enabled := False;
    end;
  end;
end;

procedure TfrmBeaconServer.BeaconMsg(const AMsg: string);
begin
  mmoBeaconMessages.Lines.Add(AMsg);
end;

procedure TfrmBeaconServer.FormCreate(Sender: TObject);
var
  LBeaconServerSettings: TBeaconServerSettings;
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  FServerDataPath := TPath.GetDocumentsPath;
  {$ELSEIF DEFINED(MSWINDOWS)}
  FServerDataPath := TPath.Combine(TPath.GetPublicPath, 'FearlessBeaconServer');
  ForceDirectories(FServerDataPath);
  {$ENDIF}

  LoadServerSettings(LBeaconServerSettings);

  BeaconDevice.ManufacturerId := FEARLESS_BEACON_MFG_ID;
  BeaconDevice.GUID    := StringToGUID(FEARLESS_BEACON_UUID);
  BeaconDevice.Major   := LBeaconServerSettings.MajorID;
  BeaconDevice.Minor   := LBeaconServerSettings.MinorID;
  BeaconDevice.TxPower := LBeaconServerSettings.PwrLevel;

  lblBeaconUUID.Text    := 'UUID: ' + FEARLESS_BEACON_UUID;
  lblBeaconIDs.Text     := Format('Beacon ID: %d-%d', [BeaconDevice.Major, BeaconDevice.Minor]);
  lblBeaconTxPower.Text := 'TX Power: ' + BeaconDevice.TxPower.ToString;

  actBeaconStart.Enabled := True;
end;

procedure TfrmBeaconServer.LoadServerSettings(var AServerSettings: TBeaconServerSettings);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(TPath.Combine(FServerDataPath, SERVER_SETTINGS_INI_FILENAME));
  try
    AServerSettings.MajorID := 2; //IniFile.ReadInteger(INIKEY_IDSection, ININame_IDMajor, 1);
    AServerSettings.MinorID := 4; //Inifile.ReadInteger(INIKEY_IDSection, ININame_IDMinor, 0);
    AServerSettings.PwrLevel := 25; //IniFile.ReadInteger(INIKEY_ConfigSection, ININame_ConfigPowerLevel, DEFAULT_TXPOWER);
  finally
    IniFile.Free;
  end;

  if (AServerSettings.MajorID = 1) and (AServerSettings.MinorID = 0) and
     (AServerSettings.PwrLevel = DEFAULT_TXPOWER) then
    // all the values are at default--it's likely the file doesn't exist, so create it by writing them out
    SaveServerSettings(AServerSettings);
end;

procedure TfrmBeaconServer.SaveServerSettings(const AServerSettings: TBeaconServerSettings);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(TPath.Combine(FServerDataPath, SERVER_SETTINGS_INI_FILENAME));
  try
    IniFile.WriteInteger(INIKEY_IDSection, ININame_IDMajor, AServerSettings.MajorID);
    Inifile.WriteInteger(INIKEY_IDSection, ININame_IDMinor, AServerSettings.MinorID);
    IniFile.WriteInteger(INIKEY_ConfigSection, ININame_ConfigPowerLevel, AServerSettings.PwrLevel);
  finally
    IniFile.Free;
  end;
end;

end.
