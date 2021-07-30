unit ufrmHideStringMain;

interface

uses
  {$IFDEF MSWINDOWS}
  WinAPI.Windows,
  {$ENDIF}
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
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  end;

var
  frmHideStrMain: TfrmHideStrMain;

implementation

{$R *.fmx}

type
  THideStringFunc = function(const MyString: string): string; stdcall;
var
  DllHandle: HModule;
  HideString: THideStringFunc;


procedure TfrmHideStrMain.btnHideStringClick(Sender: TObject);
begin
  lblHidden.Text := HideString(edtInput.Text);
end;

procedure TfrmHideStrMain.FormActivate(Sender: TObject);
begin
  DllHandle := LoadLibrary('HideStringLib.dll');
  if DLLHandle = 0 then begin
    lblHidden.Text := 'Could not find function library';
    btnHideString.Enabled := False;
  end else
    @HideString := GetProcAddress(DllHandle, 'HideString');
end;

procedure TfrmHideStrMain.FormDestroy(Sender: TObject);
begin
  if DLLHandle <> 0 then
    FreeLibrary(DllHandle);
end;

end.
