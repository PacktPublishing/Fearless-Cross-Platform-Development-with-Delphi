unit ufrmHelloDeviceMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmHello = class(TForm)
    lblHello: TLabel;
    procedure FormCreate(Sender: TObject);
  end;

var
  frmHello: TfrmHello;

implementation

{$R *.fmx}

procedure TfrmHello.FormCreate(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  lblHello.Text := 'Hello Microsoft!';
  {$ELSEIF DEFINED(MACOS)}
  lblHello.Text := 'Hello Apple!';
  {$ELSEIF DEFINED(ANDROID)}
  lblHello.Text := 'Hello Android device!';
  {$ELSE}
  lblHello.Text := 'Hello Unknown device!';
  {$ENDIF}
end;

end.
