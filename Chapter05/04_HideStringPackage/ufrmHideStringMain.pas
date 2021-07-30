unit ufrmHideStringMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit,
  FMX.Controls.Presentation;

type
  TfrmHideStrMain = class(TForm)
    Label1: TLabel;
    edtInput: TEdit;
    Label2: TLabel;
    btnHideString: TButton;
    lblHidden: TLabel;
    procedure btnHideStringClick(Sender: TObject);
  end;

var
  frmHideStrMain: TfrmHideStrMain;

implementation

{$R *.fmx}

uses
  uHideStringFunc;

procedure TfrmHideStrMain.btnHideStringClick(Sender: TObject);
begin
  lblHidden.Text := HideString(edtInput.Text);
end;

end.
