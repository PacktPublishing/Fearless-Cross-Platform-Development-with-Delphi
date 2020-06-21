program SecretStringConsole;
{$APPTYPE CONSOLE}

uses SysUtils;

function HideString(const MyString: ShortString): ShortString;
begin
  // manipulate the string to hide its original contents
  for var i := 1 to Length(MyString) do
    Result := Result + Chr(Random(26) + Ord('A')) + MyString[i];
end;

var
  astr: ShortString;
  ostr: ShortString;
  done: Boolean;
begin
  done := False;
  repeat
    Write('Enter a string to hide or "quit" to exit: ');
    Readln(astr);
    if Length(astr) > 0 then
      if SameText(Trim(astr), 'quit') then
        done := True
      else begin
        ostr := HideString(astr);
        Writeln('Your hidden string is: ' + ostr);
      end;
  until done;
end.
