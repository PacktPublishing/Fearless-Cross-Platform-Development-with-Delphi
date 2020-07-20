program ControlDemo;
{$APPTYPE CONSOLE}

const
  MY_FAV_LANG = 'Delphi';
  OTHER_LANGUAGES: array[1..4] of string = ('C++', 'Java', 'Python', 'SQL');
var
  i: Integer;
  lang: string;
  Found: Boolean;
  MyLanguageName: string;
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

  Readln;
end.
