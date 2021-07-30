program BasicSyntaxDemo;
{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  MY_FAV_LANG = 'Delphi';
  OTHER_LANGUAGES: array[1..4] of string = ('C++', 'Java', 'Python', 'SQL');
var
  NumStr: string;
  Num: Integer;
  MyLanguageName: string;
begin
  { favorite language }
  Write('What''s your favorite language? ');
  Readln(MyLanguageName);

  if MyLanguageName = MY_FAV_LANG then
    Writeln('Really? That''s mine, too!')
  else begin
    var Found := False;
    for var lang in OTHER_LANGUAGES do      // do we know about the entered language?
      if MyLanguageName = lang then begin
        Writeln('That''s a good language');
        Found := True;
        Break;
      end;

    if not Found then
      Writeln('I do not know about that language');
  end;

  { pick a number }
  var valid := False;
  repeat
    Writeln;

    repeat
      Write('Enter a number from 1 to 9: ');
      try
        try
          Readln(NumStr);            // read the input into a string to prevent errors
          Num := StrToInt(NumStr);
          valid := True;
        finally
          Writeln('You entered: "' + NumStr + '"');
        end;
      except
        Writeln('Please give a valid numberic answer.');
      end;
    until valid;

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
  until valid;

  Readln;
end.
