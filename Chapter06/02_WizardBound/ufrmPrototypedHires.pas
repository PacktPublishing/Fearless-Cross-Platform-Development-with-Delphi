unit ufrmPrototypedHires;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.GenData, Fmx.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Controls,
  FMX.EditBox, FMX.NumberBox, FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls,
  FMX.Layouts, Fmx.Bind.Navigator, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.ObjectScope, Data.Bind.Grid,
  Fmx.Bind.Grid, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TForm1 = class(TForm)
    EditContactTitle1: TEdit;
    LabelContactTitle1: TLabel;
    NavigatorPrototypeBindSource1: TBindNavigator;
    DateEditDateTimeField1: TDateEdit;
    LabelDateTimeField1: TLabel;
    EditContactName1: TEdit;
    LabelContactName1: TLabel;
    ImageContactBitmap1: TImage;
    CheckBoxBoolField1: TCheckBox;
    NumberBoxIntField1: TNumberBox;
    LabelIntField1: TLabel;
    BindingsList1: TBindingsList;
    PrototypeBindSource1: TPrototypeBindSource;
    LinkPropertyToFieldTitle: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    GridPrototypeBindSource1: TGrid;
    LinkGridToDataSourcePrototypeBindSource12: TLinkGridToDataSource;
    Rectangle1: TRectangle;
    lblContactName: TLabel;
    LinkPropertyToFieldContactName: TLinkPropertyToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
