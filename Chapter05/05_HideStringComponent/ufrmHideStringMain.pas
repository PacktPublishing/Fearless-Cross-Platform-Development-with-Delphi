unit ufrmHideStringMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit,
  FMX.Controls.Presentation, uHideStringComponent;

type
  TfrmHideStrMain = class(TForm)
    Label1: TLabel;
    edtInput: TEdit;
    Label2: TLabel;
    btnHideString: TButton;
    lblHidden: TLabel;
    HideString1: THideString;
    chkUseDigits: TCheckBox;
    chkReverse: TCheckBox;
    procedure btnHideStringClick(Sender: TObject);
  end;

var
  frmHideStrMain: TfrmHideStrMain;

implementation

{$R *.fmx}


procedure TfrmHideStrMain.btnHideStringClick(Sender: TObject);
begin
  HideString1.UseDigits := chkUseDigits.IsChecked;
  HideString1.Reverse   := chkReverse.IsChecked;

  lblHidden.Text := HideString1.Execute(edtInput.Text);
end;

end.
