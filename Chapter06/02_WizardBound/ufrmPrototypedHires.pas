unit ufrmPrototypedHires;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.GenData, Fmx.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Controls,
  FMX.EditBox, FMX.NumberBox, FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls,
  FMX.Layouts, Fmx.Bind.Navigator, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.ObjectScope, Data.Bind.Grid;

type
  TForm1 = class(TForm)
    BindingsList1: TBindingsList;
    PrototypeBindSource1: TPrototypeBindSource;
    EditContactTitle1: TEdit;
    LabelContactTitle1: TLabel;
    LinkControlToFieldContactTitle1: TLinkControlToField;
    NavigatorPrototypeBindSource1: TBindNavigator;
    DateEditDateTimeField1: TDateEdit;
    LabelDateTimeField1: TLabel;
    LinkControlToFieldDateTimeField1: TLinkControlToField;
    EditContactName1: TEdit;
    LabelContactName1: TLabel;
    LinkControlToFieldContactName1: TLinkControlToField;
    ImageContactBitmap1: TImage;
    LinkControlToFieldContactBitmap1: TLinkControlToField;
    CheckBoxBoolField1: TCheckBox;
    LinkControlToFieldBoolField1: TLinkControlToField;
    NumberBoxIntField1: TNumberBox;
    LabelIntField1: TLabel;
    LinkControlToFieldIntField1: TLinkControlToField;
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
