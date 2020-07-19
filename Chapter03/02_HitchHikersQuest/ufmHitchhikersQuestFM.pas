unit ufmHitchhikersQuestFM;

interface

uses
  {$IFDEF MSWINDOWS}
  WinAPI.Windows,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TUniversalLifeAnswerFunc = function: Integer; stdcall;

  TfrmHitchhikersQuest = class(TForm)
    Label1: TLabel;
    btnAnswer: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAnswerClick(Sender: TObject);
  private
    FLibHandle: HModule;
    FLifesAnswer: TUniversalLifeAnswerFunc;
    procedure LoadLib;
    procedure UnloadLib;
    procedure ShowAnswer;
  end;

var
  frmHitchhikersQuest: TfrmHitchhikersQuest;

implementation

{$R *.fmx}

procedure TfrmHitchhikersQuest.btnAnswerClick(Sender: TObject);
begin
  ShowAnswer;
end;

procedure TfrmHitchhikersQuest.FormCreate(Sender: TObject);
begin
  LoadLib;
end;

procedure TfrmHitchhikersQuest.FormDestroy(Sender: TObject);
begin
  UnloadLib;
end;

procedure TfrmHitchhikersQuest.LoadLib;
const
  {$IFDEF MSWINDOWS}
  LibName = 'HHGuide.dll';
  {$ELSEIF DEFINED(MACOS)}
  LibName = '../Resources/Startup/libHHGuide.dylib';
  {$ENDIF}
begin
  FLibHandle := LoadLibrary(LibName);

  if FLibHandle = 0 then
    ShowMessage('Could not load ' + LibName)
  else
    @FLifesAnswer := GetProcAddress(FLibHandle, 'UniversalLifeAnswer');
end;

procedure TfrmHitchhikersQuest.ShowAnswer;
begin
  if FLibHandle = 0 then
    ShowMessage('Function library not available--you''ll have to search for your answer elsewhere.')
  else
    ShowMessage('The answer is: ' + IntToStr(FLifesAnswer));
end;

procedure TfrmHitchhikersQuest.UnloadLib;
begin
  FreeLibrary(FLibHandle);
end;

end.
