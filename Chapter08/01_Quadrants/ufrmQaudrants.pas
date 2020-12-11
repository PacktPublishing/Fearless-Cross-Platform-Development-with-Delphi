unit ufrmQaudrants;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, FMX.Objects, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources;

type
  TForm8 = class(TForm3D)
    Cube1: TCube;
    Cone1: TCone;
    PlaneVertical: TPlane;
    PlaneHorizontal: TPlane;
    ColorMaterialSourceBlue: TColorMaterialSource;
    LightMaterialSourceGreen: TLightMaterialSource;
    Sphere1: TSphere;
    TextureMaterialSourceGlobe: TTextureMaterialSource;
    LightMaterialSourceBlue: TLightMaterialSource;
    Cube2: TCube;
    Light1: TLight;
    Text3D1: TText3D;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}

end.
