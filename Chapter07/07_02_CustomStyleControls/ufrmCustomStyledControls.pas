unit ufrmCustomStyledControls;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components;

type
  TfrmCustomStyledControls = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    RadioButton1: TRadioButton;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    ListBox1: TListBox;
    cmbStyle: TComboBox;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    BindingsList1: TBindingsList;
    LinkControlToPropertyValue: TLinkControlToProperty;
    LinkControlToPropertyIsChecked: TLinkControlToProperty;
    Edit2: TEdit;
    Edit3: TEdit;
    StyleBook1: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomStyledControls: TfrmCustomStyledControls;

implementation

{$R *.fmx}

end.
