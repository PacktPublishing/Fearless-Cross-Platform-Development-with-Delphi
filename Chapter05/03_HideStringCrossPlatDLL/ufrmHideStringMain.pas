unit ufrmHideStringMain;

interface

uses
  {$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}
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
    procedure FormDeactivate(Sender: TObject);
  end;

var
  frmHideStrMain: TfrmHideStrMain;

implementation

{$R *.fmx}

const
  {$IFDEF MSWINDOWS}       LIB_NAME = 'HideStringLib.dll';
  {$ELSEIF DEFINED(MACOS)} LIB_NAME = 'libHideStringLib.dylib';
  {$ELSEIF DEFINED(LINUX)} LIB_NAME = 'libHideStringLib.so';
  {$ENDIF}
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
  DllHandle := LoadLibrary(LIB_NAME);
  if DLLHandle = 0 then begin
    lblHidden.Text := 'Could not find function library: ' + LIB_NAME;
    btnHideString.Enabled := False;
  end else
    @HideString := GetProcAddress(DllHandle, 'HideString');
end;

procedure TfrmHideStrMain.FormDeactivate(Sender: TObject);
begin
  FreeLibrary(DllHandle);
end;

end.
