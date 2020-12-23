
unit ufrmQuadrants;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Objects, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layers3D, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, FMX.Media;

type
  Tfrm3DQuadrants = class(TForm3D)
    Cube1: TCube;
    ConeChristmasTree: TCone;
    PlaneHorizontal: TPlane;
    SphereGlobe: TSphere;
    TextureMaterialSourceGlobe: TTextureMaterialSource;
    LightMaterialSourceBlue: TLightMaterialSource;
    Light1: TLight;
    txtQuadrant: TText3D;
    FloatAnimation1: TFloatAnimation;
    LightMaterialSourceGreenery: TLightMaterialSource;
    ColorMaterialSourceGray: TColorMaterialSource;
    ColorMaterialSourceBlack: TColorMaterialSource;
    bulb7: TSphere;
    bulb8: TSphere;
    bulb1: TSphere;
    bulb2: TSphere;
    bulb3: TSphere;
    bulb4: TSphere;
    bulb5: TSphere;
    bulb6: TSphere;
    Path3dStar: TPath3D;
    ConeChristmasTree3: TCone;
    Sphere1: TSphere;
    Sphere2: TSphere;
    Sphere3: TSphere;
    Sphere4: TSphere;
    Sphere5: TSphere;
    Sphere6: TSphere;
    Sphere7: TSphere;
    Sphere8: TSphere;
    Path3DStar3: TPath3D;
    ConeChristmasTree2: TCone;
    Sphere9: TSphere;
    Sphere10: TSphere;
    Sphere11: TSphere;
    Sphere12: TSphere;
    Sphere13: TSphere;
    Sphere14: TSphere;
    Sphere15: TSphere;
    Sphere16: TSphere;
    Path3DStar2: TPath3D;
    FloatAnimationBackAndForth: TFloatAnimation;
    cylArrowStemY: TCylinder;
    coneArrowTipY: TCone;
    Text3DYAxis: TText3D;
    Layer3DOptions: TLayer3D;
    grpLight: TGroupBox;
    Label3: TLabel;
    SwitchLight: TSwitch;
    tbLightRotateX: TTrackBar;
    Label2: TLabel;
    Label1: TLabel;
    BindingsList1: TBindingsList;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
    LinkControlToPropertyEnabled2: TLinkControlToProperty;
    btnShowOptions: TButton;
    Model3DElk: TModel3D;
    ColorMaterialSourceBrown: TColorMaterialSource;
    grpElk: TGroupBox;
    tbElkRotate: TTrackBar;
    lblElkRotate: TLabel;
    tbElkScale: TTrackBar;
    lblElkScale: TLabel;
    LinkControlToPropertyScaleX: TLinkControlToProperty;
    LinkControlToPropertyScaleY: TLinkControlToProperty;
    LinkControlToPropertyScaleZ: TLinkControlToProperty;
    LinkControlToPropertyRotationAngleY: TLinkControlToProperty;
    LinkControlToPropertyRotationAngleY2: TLinkControlToProperty;
    CylinderTreeTrunk: TCylinder;
    LightMaterialSourceWood: TLightMaterialSource;
    Cylinder1: TCylinder;
    Cylinder2: TCylinder;
    ColorMaterialSourceStar: TColorMaterialSource;
    ColorAnimationTwinkle: TColorAnimation;
    CameraCube: TCamera;
    CameraElk: TCamera;
    CameraEarthSat: TCamera;
    StyleBook1: TStyleBook;
    procedure btnShowOptionsClick(Sender: TObject);
    procedure Form3DCreate(Sender: TObject);
    procedure btnShowXYClick(Sender: TObject);
    procedure Model3DElkDblClick(Sender: TObject);
    procedure Form3DKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Model3DElkClick(Sender: TObject);
    procedure CubeClick(Sender: TObject);
    procedure SphereGlobeClick(Sender: TObject);
  private
    procedure SwitchToCameraElk;
    procedure SwitchToCameraCube;
    procedure SwitchToCameraEarthSat;
    procedure SwitchToCameraDefault;
    procedure ResetCameras;
    procedure StartTreeLightsBlinking;
  end;

var
  frm3DQuadrants: Tfrm3DQuadrants;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure Tfrm3DQuadrants.btnShowOptionsClick(Sender: TObject);
begin
  if Layer3DOptions.Width = 20 then begin
    Layer3DOptions.Width := 120;
    btnShowOptions.StyleLookup := 'arrowrighttoolbutton';
  end else begin
    Layer3DOptions.Width := 20;
    btnShowOptions.StyleLookup := 'arrowlefttoolbutton';
  end;

  grpLight.Visible  := Layer3DOptions.Width = 120;
  grpElk.Visible    := Layer3DOptions.Width = 120;
end;

procedure Tfrm3DQuadrants.btnShowXYClick(Sender: TObject);
begin
  ShowMessage(Format('Current camera position (%f, %f, %f)',
                     [Camera.Position.X, Camera.Position.Y, Camera.Position.Z]));
end;

procedure Tfrm3DQuadrants.CubeClick(Sender: TObject);
begin
  SwitchToCameraCube;
end;

procedure Tfrm3DQuadrants.Form3DCreate(Sender: TObject);
begin
  for var AMesh in Model3DElk.MeshCollection do
    AMesh.MaterialSource := ColorMaterialSourceBrown;

  grpLight.Visible := False;
  grpElk.Visible := False;

  Layer3DOptions.Width := 20;

  StartTreeLightsBlinking;
end;

procedure Tfrm3DQuadrants.Form3DKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    ResetCameras;
end;

procedure Tfrm3DQuadrants.Model3DElkClick(Sender: TObject);
begin
  SwitchToCameraElk;
end;

procedure Tfrm3DQuadrants.Model3DElkDblClick(Sender: TObject);
begin
  SwitchToCameraElk;
end;

procedure Tfrm3DQuadrants.ResetCameras;
begin
  SwitchToCameraDefault;
end;

procedure Tfrm3DQuadrants.SphereGlobeClick(Sender: TObject);
begin
  SwitchToCameraEarthSat;
end;

procedure Tfrm3DQuadrants.StartTreeLightsBlinking;
var
  NewFloatAnimation: TFloatAnimation;
begin
  for var bulb := 1 to 8 do begin
    NewFloatAnimation := TFloatAnimation.Create(self);
    NewFloatAnimation.Parent := FindComponent('bulb' + bulb.ToString) as TSphere;
    if Assigned(NewFloatAnimation.Parent) then begin
      NewFloatAnimation.Duration := 0.5 + Random;
      NewFloatAnimation.Delay := 0.5 + Random;
      NewFloatAnimation.StartValue := 0.0;
      NewFloatAnimation.StopValue  := 1.0;
      NewFloatAnimation.Loop := True;
      NewFloatAnimation.AutoReverse := True;
      NewFloatAnimation.PropertyName := 'Opacity';
      NewFloatAnimation.Enabled := True;
    end;
  end;
end;

procedure Tfrm3DQuadrants.SwitchToCameraCube;
begin
  if Camera = CameraCube then
    SwitchToCameraDefault
  else begin
    UsingDesignCamera := False;
    Camera := CameraCube;
    Camera.Repaint;
  end;
end;

procedure Tfrm3DQuadrants.SwitchToCameraDefault;
begin
  UsingDesignCamera := True;
  Sleep(100); // prevents needing to call this method twice
  Camera.Repaint;
end;

procedure Tfrm3DQuadrants.SwitchToCameraEarthSat;
begin
  if Camera = CameraEarthSat then
    SwitchToCameraDefault
  else begin
    UsingDesignCamera := False;
    Camera := CameraEarthSat;
    Camera.Repaint;
  end;
end;

procedure Tfrm3DQuadrants.SwitchToCameraElk;
begin
  if Camera = CameraElk then
    SwitchToCameraDefault
  else begin
    UsingDesignCamera := False;
    Camera := CameraElk;
    Camera.Repaint;
  end;
end;

end.
