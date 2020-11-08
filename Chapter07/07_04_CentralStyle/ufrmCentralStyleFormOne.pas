unit ufrmCentralStyleFormOne;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.StdCtrls, FMX.Edit, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation;

type
  TfrmCentralStyleFormOne = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    ProgressBar1: TProgressBar;
    ListBox1: TListBox;
    cmbStyle: TComboBox;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    BindingsList1: TBindingsList;
    LinkControlToPropertyValue: TLinkControlToProperty;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCentralStyleFormOne: TfrmCentralStyleFormOne;

implementation

{$R *.fmx}

uses udmStyles;

end.
