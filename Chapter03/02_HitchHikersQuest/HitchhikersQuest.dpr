program HitchhikersQuest;
{$APPTYPE CONSOLE}

uses
  {$IFDEF MSWINDOWS} WinAPI.Windows, {$ENDIF}
  System.SysUtils;

const
  {$IFDEF MSWINDOWS}
  LibName = 'HHGuide.dll';
  {$ELSEIF DEFINED(MACOS)}
  LibName = 'libHHGuide.dylib';
  {$ELSEIF DEFINED(LINUX)}
  LibName = 'libHHGuide.so';
  {$ENDIF}
type
  TUniversalLifeAnswerFunc = function: Integer; cdecl;
var
  DLLHandle: HModule;
  LifesAnswer: TUniversalLifeAnswerFunc;
begin
  DLLHandle := LoadLibrary(LibName);

  if DLLHandle = 0 then
    Writeln('Could not load ' + LibName)
  else begin
    @LifesAnswer := GetProcAddress(DLLHandle, 'UniversalLifeAnswer');
    Writeln('What is the answer to life?');
    Writeln(LifesAnswer);
    Readln;
  end;

  FreeLibrary(DLLHandle);
end.
