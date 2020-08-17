unit ufrmHelloMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    edtName: TEdit;
    Label1: TLabel;
    btnSayHello: TButton;
    procedure btnSayHelloClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnSayHelloClick(Sender: TObject);
begin
  MessageDlg('Hello, ' + edtName.Text, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
end;

end.
