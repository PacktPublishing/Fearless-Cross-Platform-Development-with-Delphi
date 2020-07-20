program ControlDemo;
{$APPTYPE CONSOLE}

const
  MY_FAV_LANG = 'Delphi';
var
  MyLanguageName: string;
begin
  Write('What''s your favorite language? ');
  Readln(MyLanguageName);

  if MyLanguageName = MY_FAV_LANG then
    Writeln('Really? That''s mine, too!')
  else begin
    Writeln('Cool!  Mine is ' + MY_FAV_LANG);
    Writeln('You should try ' + MY_FAV_LANG);
  end;

  Readln;
end.
