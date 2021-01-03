unit ufrmEscape1985Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Layers3D, FMX.Controls3D, FMX.Objects3D,
  FMX.Ani, FMX.MaterialSources, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Objects;

type
  TfrmEscape1985 = class(TForm3D)
    DummyMain: TDummy;
    Image3DRoom: TImage3D;
    CameraRoom: TCamera;
    Rectangle3DNotepad: TRectangle3D;
    ColorMaterialSourceWhite: TColorMaterialSource;
    FloatAnimationNotepadOpacity: TFloatAnimation;
    FloatAnimationNotepadX: TFloatAnimation;
    FloatAnimationNotepadY: TFloatAnimation;
    FloatAnimationNotepadRotateZ: TFloatAnimation;
    FloatAnimationNotepadWidth: TFloatAnimation;
    FloatAnimationNotepadHeight: TFloatAnimation;
    DummyNotepad: TDummy;
    FloatAnimationNotepadScaleX: TFloatAnimation;
    FloatAnimationNotepadScaleY: TFloatAnimation;
    lblNotepadPowerLevelHdr: TLabel;
    Layer3DNotepad: TLayer3D;
    DummyControls: TDummy;
    Rectangle3DControls: TRectangle3D;
    FloatAnimCtrlScaleX: TFloatAnimation;
    FloatAnimCtrlScaleY: TFloatAnimation;
    FloatAnimationCtrlHeight: TFloatAnimation;
    FloatAnimationCtrlX: TFloatAnimation;
    FloatAnimationCtrlY: TFloatAnimation;
    FloatAnimationCtrlWidth: TFloatAnimation;
    lblNotepadLights: TLabel;
    lblNotepadComputers: TLabel;
    lblNotepadTimePortal: TLabel;
    lblNotepadOpSecCode: TLabel;
    lblNotepadSecCodeHdr: TLabel;
    ColorMaterialSourceControls: TColorMaterialSource;
    lblNotepadPowerOverride: TLabel;
    FloatAnimCtrlOpacity: TFloatAnimation;
    Layer3DControls: TLayer3D;
    lblControlSecCode: TLabel;
    lblControlSCP: TLabel;
    mmoControlNotice: TMemo;
    pbControlSCP: TProgressBar;
    tmrSecCodePrefix: TTimer;
    RectSecCode1: TRectangle;
    RectSecCode2: TRectangle;
    RectSecCode3: TRectangle;
    RectSecCode4: TRectangle;
    RectSecCode5: TRectangle;
    RectSecCode6: TRectangle;
    lblControlPWR: TLabel;
    lblSecCode1: TLabel;
    lblSecCode2: TLabel;
    lblSecCode3: TLabel;
    lblSecCode4: TLabel;
    lblSecCode5: TLabel;
    lblSecCode6: TLabel;
    StyleBook1: TStyleBook;
    CylinderPowerLevelOuter: TCylinder;
    LightMaterialSourceBlack: TLightMaterialSource;
    LightMaterialSourceRed: TLightMaterialSource;
    LightRoom: TLight;
    CylinderPowerLevelInner: TCylinder;
    LightMaterialSourceGreen: TLightMaterialSource;
    LightMaterialSourceYellow: TLightMaterialSource;
    Button1: TButton;
    Button2: TButton;
    Text3DPowerPercent: TText3D;
    procedure Rectangle3DNotepadClick(Sender: TObject);
    procedure Form3DCreate(Sender: TObject);
    procedure FloatAnimationFinish(Sender: TObject);
    procedure Rectangle3DControlsClick(Sender: TObject);
    procedure tmrSecCodePrefixTimer(Sender: TObject);
    procedure lblSecCodeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    const
      CLICKABLE_OBJECTS_Z = -0.8;
      ZOOMED_OBJECTS_Z = -1.0;
      MAX_SEC_CODE_COUNTDOWN = 60;
      MAX_SEC_CODES = 6;
      POWER_LEVEL_GREEN_MAX = 80;
      POWER_LEVEL_YELLOW_MAX = 100;
      POWER_LEVEL_RED_MAX = 150;
      POWER_LEVEL_RESET_THRESHHOLD = 90;
      POWER_LEVEL_LIGHTS = 35;
    var
      FNotepadShowing: Boolean;
      FControlsShowing: Boolean;
      FSecCodePrefix: Integer;
      FSecCodeCountdown: Integer;
      FSecCodes: array[1..MAX_SEC_CODES] of Integer;
      FCurrPowerPercent: Integer;
    procedure InvalidActionSound;
    procedure ResetSecCodeCountDown;
    procedure InitializeSecCodes;
    procedure UpdateSecCodeDisplay;
    procedure SetupNotepad;
    procedure SetupControls;
    procedure ShowNotepad;
    procedure ShowControls;
    procedure SetPowerLevel(const NewPowerPercent: Integer);
    procedure RaisePower(const PowerIncreasePercent: Integer);
    procedure LowerPower(const PowerDecreasePercent: Integer);
  end;

var
  frmEscape1985: TfrmEscape1985;

implementation

{$R *.fmx}

{.$DEFINE VisualTestNotepad}
{.$DEFINE VisualTestControls}

uses
  System.Math;

procedure TfrmEscape1985.Button1Click(Sender: TObject);
begin
  RaisePower(10);
end;

procedure TfrmEscape1985.Button2Click(Sender: TObject);
begin
  LowerPower(10);
end;

procedure TfrmEscape1985.FloatAnimationFinish(Sender: TObject);
begin
  (Sender as TFloatAnimation).Enabled := False;
end;

procedure TfrmEscape1985.Form3DCreate(Sender: TObject);
begin
  FNotepadShowing := False;
  FControlsShowing := False;

  SetupNotepad;
  SetupControls;
end;

procedure TfrmEscape1985.InitializeSecCodes;
begin
  for var i := 1 to MAX_SEC_CODES do
    FSecCodes[i] := 0;
end;

procedure TfrmEscape1985.InvalidActionSound;
begin
  { TODO : add short sound that indicates invalid action }
end;

procedure TfrmEscape1985.lblSecCodeClick(Sender: TObject);
var
  LSecNum: ShortInt;
begin
  LSecNum := (Sender as TLabel).Tag;
  if LSecNum in [1..MAX_SEC_CODES] then begin
    FSecCodes[LSecNum] := FSecCodes[LSecNum] + 1;
    if FSecCodes[LSecNum] > 9 then
      FSecCodes[LSecNum] := 0;
  end;

  UpdateSecCodeDisplay;
end;

procedure TfrmEscape1985.ResetSecCodeCountDown;
begin
  FSecCodePrefix := Random(900) + 100; // 0 to 899 + 100 = 100 to 999
  lblControlSCP.Text := 'SCP: ' + IntToStr(FSecCodePrefix);

  FSecCodeCountdown := MAX_SEC_CODE_COUNTDOWN;
  pbControlSCP.Value := FSecCodeCountdown;

  if FCurrPowerPercent > POWER_LEVEL_RESET_THRESHHOLD then
    SetPowerLevel(POWER_LEVEL_GREEN_MAX);
end;

procedure TfrmEscape1985.tmrSecCodePrefixTimer(Sender: TObject);
begin
  if FSecCodeCountdown < 0 then
    ResetSecCodeCountDown
  else begin
    Dec(FSecCodeCountdown);
    pbControlSCP.Value := FSecCodeCountdown;
  end;
end;

procedure TfrmEscape1985.UpdateSecCodeDisplay;
begin
  for var i := 1 to 6 do
    (FindComponent('lblSecCode' + i.ToString) as TLabel).Text := IntToStr(FSecCodes[i]);
end;

procedure TfrmEscape1985.Rectangle3DControlsClick(Sender: TObject);
begin
  ShowControls;
end;

procedure TfrmEscape1985.Rectangle3DNotepadClick(Sender: TObject);
begin
  ShowNotepad;
end;

procedure TfrmEscape1985.SetPowerLevel(const NewPowerPercent: Integer);
// calculate height and width of inner cylinder to simulate power level meter
// if new power percent crosses color threshhold, change color of inner cylinder
const
  POWER_100_PERCENT_HEIGHT = 3.4;
  POWER_MAX_PERCENT_HEIGHT = 3.8;
var
  CalculatedHeight: Single;
  CalculatedY: Single;
begin
  // never go below 0%
  if NewPowerPercent >= 0 then begin
    FCurrPowerPercent := NewPowerPercent;
    Text3DPowerPercent.Text := FCurrPowerPercent.ToString + '%';

    CalculatedHeight := (NewPowerPercent / 100.0) * POWER_100_PERCENT_HEIGHT;
    if CalculatedHeight > POWER_MAX_PERCENT_HEIGHT then
      CalculatedHeight := POWER_MAX_PERCENT_HEIGHT;

    CalculatedY := (POWER_MAX_PERCENT_HEIGHT / 2.0) - (CalculatedHeight / 2.0);

    CylinderPowerLevelInner.Height := CalculatedHeight;
    CylinderPowerLevelInner.Position.Y := CalculatedY;

    if (FCurrPowerPercent >= 0) and (FCurrPowerPercent <= POWER_LEVEL_GREEN_MAX) then
      CylinderPowerLevelInner.MaterialSource := LightMaterialSourceGreen
    else if FCurrPowerPercent <= POWER_LEVEL_YELLOW_MAX then
      CylinderPowerLevelInner.MaterialSource := LightMaterialSourceYellow
    else
      CylinderPowerLevelInner.MaterialSource := LightMaterialSourceRed;
  end;
end;

procedure TfrmEscape1985.RaisePower(const PowerIncreasePercent: Integer);
begin
  if FCurrPowerPercent < POWER_LEVEL_RED_MAX then
    SetPowerLevel(FCurrPowerPercent + PowerIncreasePercent)
  else
    InvalidActionSound;
end;

procedure TfrmEscape1985.LowerPower(const PowerDecreasePercent: Integer);
begin
  if FCurrPowerPercent - PowerDecreasePercent > POWER_LEVEL_LIGHTS then
    SetPowerLevel(FCurrPowerPercent - PowerDecreasePercent)
  else begin
    InvalidActionSound;
    ShowMessage('Please don''t turn off the lights.');
  end;
end;

procedure TfrmEscape1985.SetupControls;
const
  SMALL_SIZE_X = 11.5;
  SMALL_SIZE_Y = 3.5;
  FULL_SIZE_X = 10.7;
  FULL_SIZE_Y = 5.9;
  SMALL_SIZE_HEIGHT = 1;
  SMALL_SIZE_WIDTH  = 2.6;
  FULL_SIZE_HEIGHT = 7.5;
  FULL_SIZE_WIDTH  = 18.2;
begin
  DummyControls.Position.X := SMALL_SIZE_X;
  DummyControls.Position.Y := SMALL_SIZE_Y;
  DummyControls.Height     := SMALL_SIZE_HEIGHT;
  DummyControls.Width      := SMALL_SIZE_WIDTH;
  DummyControls.Position.Z := CLICKABLE_OBJECTS_Z;

  FloatAnimationCtrlX.StartValue := SMALL_SIZE_X;
  FloatAnimationCtrlX.StopValue  := FULL_SIZE_X;
  FloatAnimationCtrlY.StartValue := SMALL_SIZE_Y;
  FloatAnimationCtrlY.StopValue  := FULL_SIZE_Y;
  FloatAnimationCtrlHeight.StartValue := SMALL_SIZE_HEIGHT;
  FloatAnimationCtrlHeight.StopValue  := FULL_SIZE_HEIGHT;
  FloatAnimationCtrlWidth.StartValue  := SMALL_SIZE_WIDTH;
  FloatAnimationCtrlWidth.StopValue   := FULL_SIZE_WIDTH;

  Rectangle3DControls.Scale.X := FloatAnimCtrlScaleX.StartValue;
  Rectangle3DControls.Scale.Y := FloatAnimCtrlScaleY.StartValue;

  {$IFNDEF VisualTestControls}
  Rectangle3DControls.Opacity := 0;
  {$ENDIF}

  pbControlSCP.Max := MAX_SEC_CODE_COUNTDOWN;
  InitializeSecCodes;
  UpdateSecCodeDisplay;
  ResetSecCodeCountDown;

  SetPowerLevel(78);
end;

procedure TfrmEscape1985.SetupNotepad;
const
  SMALL_SIZE_X = 12.5;
  SMALL_SIZE_Y = 8;
  SMALL_SIZE_HEIGHT = 1.4;
  SMALL_SIZE_WIDTH  = 1.8;
  SMALL_ROTATION_Z = 25;
  FULL_SIZE_X = 10.9;
  FULL_SIZE_Y = 5.9;
  FULL_SIZE_HEIGHT = 10.9;
  FULL_SIZE_WIDTH  = 9.5;
  FULL_ROTATION_Z  = 0;
begin
  DummyNotepad.Position.X := SMALL_SIZE_X;
  DummyNotepad.Position.Y := SMALL_SIZE_Y;
  DummyNotepad.Height     := SMALL_SIZE_HEIGHT;
  DummyNotepad.Width      := SMALL_SIZE_WIDTH;
  DummyNotepad.RotationAngle.Z := SMALL_ROTATION_Z;
  DummyNotepad.Position.Z := CLICKABLE_OBJECTS_Z;

  FloatAnimationNotepadX.StartValue := SMALL_SIZE_X;
  FloatAnimationNotepadX.StopValue  := FULL_SIZE_X;
  FloatAnimationNotepadY.StartValue := SMALL_SIZE_Y;
  FloatAnimationNotepadY.StopValue  := FULL_SIZE_Y;
  FloatAnimationNotepadWidth.StartValue  := SMALL_SIZE_WIDTH;
  FloatAnimationNotepadWidth.StopValue   := FULL_SIZE_WIDTH;
  FloatAnimationNotepadHeight.StartValue := SMALL_SIZE_HEIGHT;
  FloatAnimationNotepadHeight.StopValue  := FULL_SIZE_HEIGHT;
  FloatAnimationNotepadRotateZ.StartValue := SMALL_ROTATION_Z;
  FloatAnimationNotepadRotateZ.StopValue  := FULL_ROTATION_Z;

  Rectangle3DNotepad.Scale.X := FloatAnimationNotepadScaleX.StartValue;
  Rectangle3DNotepad.Scale.Y := FloatAnimationNotepadScaleY.StartValue;

  {$IFNDEF VisualTestNotepad}
  Rectangle3DNotepad.Opacity := 0;
  {$ENDIF}
end;

procedure TfrmEscape1985.ShowControls;
begin
  if FControlsShowing then begin
    FControlsShowing := False;

    FloatAnimationCtrlX.Inverse := True;
    FloatAnimationCtrlX.Enabled := True;

    FloatAnimationCtrlY.Inverse := True;
    FloatAnimationCtrlY.Enabled := True;

    FloatAnimationCtrlWidth.Inverse := True;
    FloatAnimationCtrlWidth.Enabled := True;

    FloatAnimationCtrlHeight.Inverse := True;
    FloatAnimationCtrlHeight.Enabled := True;

    FloatAnimCtrlScaleX.Inverse := True;
    FloatAnimCtrlScaleX.Enabled := True;

    FloatAnimCtrlScaleY.Inverse := True;
    FloatAnimCtrlScaleY.Enabled := True;

    {$IFNDEF VisualTestControls}
    FloatAnimCtrlOpacity.Inverse := True;
    FloatAnimCtrlOpacity.Enabled := True;
    {$ENDIF}

    DummyControls.Position.Z := CLICKABLE_OBJECTS_Z;
  end else begin
    FControlsShowing := True;

    DummyControls.Position.Z := ZOOMED_OBJECTS_Z;

    FloatAnimationCtrlX.Inverse := False;
    FloatAnimationCtrlX.Enabled := True;

    FloatAnimationCtrlY.Inverse := False;
    FloatAnimationCtrlY.Enabled := True;

    FloatAnimationCtrlWidth.Inverse := False;
    FloatAnimationCtrlWidth.Enabled := True;

    FloatAnimationCtrlHeight.Inverse := False;
    FloatAnimationCtrlHeight.Enabled := True;

    FloatAnimCtrlScaleX.Inverse := False;
    FloatAnimCtrlScaleX.Enabled := True;

    FloatAnimCtrlScaleY.Inverse := False;
    FloatAnimCtrlScaleY.Enabled := True;

    {$IFNDEF VisualTestControls}
    FloatAnimCtrlOpacity.Inverse := False;
    FloatAnimCtrlOpacity.Enabled := True;
    {$ENDIF}
  end;
end;

procedure TfrmEscape1985.ShowNotepad;
begin
  if FNotepadShowing then begin
    FNotepadShowing := False;

    FloatAnimationNotepadX.Inverse := True;
    FloatAnimationNotepadX.Enabled := True;

    FloatAnimationNotepadY.Inverse := True;
    FloatAnimationNotepadY.Enabled := True;

    FloatAnimationNotepadWidth.Inverse := True;
    FloatAnimationNotepadWidth.Enabled := True;

    FloatAnimationNotepadHeight.Inverse := True;
    FloatAnimationNotepadHeight.Enabled := True;

    FloatAnimationNotepadRotateZ.Inverse := True;
    FloatAnimationNotepadRotateZ.Enabled := True;

    FloatAnimationNotepadScaleX.Inverse := True;
    FloatAnimationNotepadScaleX.Enabled := True;

    FloatAnimationNotepadScaleY.Inverse := True;
    FloatAnimationNotepadScaleY.Enabled := True;

    {$IFNDEF VisualTestNotepad}
    FloatAnimationNotepadOpacity.Inverse := True;
    FloatAnimationNotepadOpacity.Enabled := True;
    {$ENDIF}

    DummyNotepad.Position.Z := CLICKABLE_OBJECTS_Z;
  end else begin
    FNotepadShowing := True;

    DummyNotepad.Position.Z := ZOOMED_OBJECTS_Z;

    FloatAnimationNotepadX.Inverse := False;
    FloatAnimationNotepadX.Enabled := True;

    FloatAnimationNotepadY.Inverse := False;
    FloatAnimationNotepadY.Enabled := True;

    FloatAnimationNotepadWidth.Inverse := False;
    FloatAnimationNotepadWidth.Enabled := True;

    FloatAnimationNotepadHeight.Inverse := False;
    FloatAnimationNotepadHeight.Enabled := True;

    FloatAnimationNotepadRotateZ.Inverse := False;
    FloatAnimationNotepadRotateZ.Enabled := True;

    FloatAnimationNotepadScaleX.Inverse := False;
    FloatAnimationNotepadScaleX.Enabled := True;

    FloatAnimationNotepadScaleY.Inverse := False;
    FloatAnimationNotepadScaleY.Enabled := True;

    {$IFNDEF VisualTestNotepad}
    FloatAnimationNotepadOpacity.Inverse := False;
    FloatAnimationNotepadOpacity.Enabled := True;
    {$ENDIF}
  end;
end;

end.
