unit udmStyles;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TdmStyles = class(TDataModule)
    StyleBook_MaterialPatternsBlue: TStyleBook;
    StyleBook_CoralCrystal: TStyleBook;
    StyleBook_PuertoRico: TStyleBook;
    StyleBook_Jet: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmStyles: TdmStyles;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
