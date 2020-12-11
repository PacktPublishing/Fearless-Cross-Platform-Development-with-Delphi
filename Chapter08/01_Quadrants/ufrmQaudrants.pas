unit ufrmQaudrants;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, FMX.Objects, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D,
  FMX.MaterialSources;

type
  Tfrm3DQuadrants = class(TForm3D)
    Cube1: TCube;
    Cone1: TCone;
    PlaneVertical: TPlane;
    PlaneHorizontal: TPlane;
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
  frm3DQuadrants: Tfrm3DQuadrants;

implementation

{$R *.fmx}

end.
