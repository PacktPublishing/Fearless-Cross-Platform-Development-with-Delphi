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
  private
    function HideString(const MyString: string): string;
  end;

var
  frmHideStrMain: TfrmHideStrMain;

implementation

{$R *.fmx}

procedure TfrmHideStrMain.btnHideStringClick(Sender: TObject);
begin
  lblHidden.Text := HideString(edtInput.Text);
end;

function TfrmHideStrMain.HideString(const MyString: string): string;
begin
  // manipulate the string to hide its original contents
  for var i := 1 to Length(MyString) do
    Result := Result + Chr(Random(26) + Ord('A')) + MyString[i];
end;

end.
