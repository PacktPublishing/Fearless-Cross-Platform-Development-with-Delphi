unit ufrmDefaultStyledControls;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components;

type
  TfrmDefaultStyledControls = class(TForm)
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
    StyleBookDark: TStyleBook;
    StyleBookGreen: TStyleBook;
    procedure cmbStyleChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDefaultStyledControls: TfrmDefaultStyledControls;

implementation

{$R *.fmx}

procedure TfrmDefaultStyledControls.cmbStyleChange(Sender: TObject);
begin
  case cmbStyle.ItemIndex of
    1: StyleBook := StyleBookDark;
    2: StyleBook := StyleBookGreen;
  else
    StyleBook := nil;
  end;
end;

end.
