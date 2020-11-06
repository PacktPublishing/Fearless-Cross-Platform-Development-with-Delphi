unit ufrmMultiFormsMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, System.Actions, FMX.ActnList;

type
  TfrmMultiFormsMain = class(TForm)
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
    btnShowBlueForm: TButton;
    aclFormButtons: TActionList;
    actShowBlueForm: TAction;
    actShowCoralForm: TAction;
    actShowPuertoRicoForm: TAction;
    Button2: TButton;
    Button3: TButton;
    procedure cmbStyleChange(Sender: TObject);
    procedure actShowBlueFormExecute(Sender: TObject);
    procedure actShowPuertoRicoFormExecute(Sender: TObject);
    procedure actShowCoralFormExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMultiFormsMain: TfrmMultiFormsMain;

implementation

{$R *.fmx}

uses
  udmStyles, ufrmMultiFormBlue, ufrmMultiFormPuertoRico, ufrmMultiFormCoral;

procedure TfrmMultiFormsMain.actShowBlueFormExecute(Sender: TObject);
begin
  frmMaterialPatternsBlue.Show;
end;

procedure TfrmMultiFormsMain.actShowCoralFormExecute(Sender: TObject);
begin
  frmMultiFormCoral.Show;
end;

procedure TfrmMultiFormsMain.actShowPuertoRicoFormExecute(Sender: TObject);
begin
  frmMultiFormPuertoRico.Show;
end;

procedure TfrmMultiFormsMain.cmbStyleChange(Sender: TObject);
begin
  case cmbStyle.ItemIndex of
    1: StyleBook := dmStyles.StyleBook_MaterialPatternsBlue;
    2: StyleBook := dmStyles.StyleBook_CoralCrystal;
    3: StyleBook := dmStyles.StyleBook_PuertoRico;
    4: StyleBook := dmStyles.StyleBook_Jet;
  else
    StyleBook := nil;
  end;
end;

end.
