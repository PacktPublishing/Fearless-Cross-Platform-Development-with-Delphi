
unit ufrmQaudrants;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, FMX.Objects, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layers3D, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components;

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
    ColorAnimation1: TColorAnimation;
    bulb7: TSphere;
    bulb8: TSphere;
    bulb1: TSphere;
    bulb2: TSphere;
    bulb3: TSphere;
    bulb4: TSphere;
    bulb5: TSphere;
    bulb6: TSphere;
    path3dStar: TPath3D;
    ColorAnimationStarGlow: TColorAnimation;
    ColorMaterialStar: TColorMaterialSource;
    Cone1: TCone;
    Sphere1: TSphere;
    Sphere2: TSphere;
    Sphere3: TSphere;
    Sphere4: TSphere;
    Sphere5: TSphere;
    Sphere6: TSphere;
    Sphere7: TSphere;
    Sphere8: TSphere;
    Path3D1: TPath3D;
    ColorMaterialSource1: TColorMaterialSource;
    ColorAnimation2: TColorAnimation;
    Cone2: TCone;
    Sphere9: TSphere;
    Sphere10: TSphere;
    Sphere11: TSphere;
    Sphere12: TSphere;
    Sphere13: TSphere;
    Sphere14: TSphere;
    Sphere15: TSphere;
    Sphere16: TSphere;
    Path3D2: TPath3D;
    ColorMaterialSource2: TColorMaterialSource;
    ColorAnimation3: TColorAnimation;
    FloatAnimationBackAndForth: TFloatAnimation;
    cylArrowStemY: TCylinder;
    coneArrowTipY: TCone;
    Text3D1: TText3D;
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
    LinkControlToPropertyRotationAngleX: TLinkControlToProperty;
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
    procedure btnShowOptionsClick(Sender: TObject);
    procedure Form3DCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm3DQuadrants: Tfrm3DQuadrants;

implementation

{$R *.fmx}

procedure Tfrm3DQuadrants.btnShowOptionsClick(Sender: TObject);
begin
  if Layer3DOptions.Width = 20 then begin
    Layer3DOptions.Width := 100;
    btnShowOptions.StyleLookup := 'arrowrighttoolbutton';
  end else begin
    Layer3DOptions.Width := 20;
    btnShowOptions.StyleLookup := 'arrowlefttoolbutton';
  end;
end;

procedure Tfrm3DQuadrants.Form3DCreate(Sender: TObject);
begin
  for var AMesh in Model3DElk.MeshCollection do
    AMesh.MaterialSource := ColorMaterialSourceBrown;
end;

end.
