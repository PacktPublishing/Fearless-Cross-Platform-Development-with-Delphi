program ControlDemo;
{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  MY_FAV_LANG = 'Delphi';
  OTHER_LANGUAGES: array[1..4] of string = ('C++', 'Java', 'Python', 'SQL');
var
  lang: string;
  NumStr: string;
  Num: Integer;
  Found: Boolean;
  MyLanguageName: string;
  valid: Boolean;
begin
  Write('What''s your favorite language? ');
  Readln(MyLanguageName);

  if MyLanguageName = MY_FAV_LANG then
    Writeln('Really? That''s mine, too!')
  else begin
    Found := False;
    for lang in OTHER_LANGUAGES do
      if MyLanguageName = lang then begin
        Writeln('That''s a good language');
        Found := True;
        Break;
      end;

    if not Found then
      Writeln('I do not know about that language');
  end;

  valid := False;
  repeat
    Writeln;
    Write('Enter a number from 1 to 9: ');
    Readln(NumStr);
    if TryStrToInt(NumStr, Num) then begin
      valid := True;
      case Num of
        1,2,3,4: Writeln('Your answer was in the bottom half of the range.');
        5:       Writeln('Your answer was in the middle of the range.');
        6..9:    Writeln('Your answer was in the upper half of the range.');
      else
        begin
          Writeln('Your answer was outside of the requested range.');
          valid := False;
        end;
      end;
    end else
      Writeln('Your answer could not be understood.');
  until valid;

  Readln;
end.
