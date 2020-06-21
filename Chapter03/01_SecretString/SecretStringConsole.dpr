program SecretStringConsole;
{$APPTYPE CONSOLE}

uses SysUtils;

function HideString(const MyString: ShortString): ShortString; stdcall;
  external 'HideStringLib.dll' name 'HideString';

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
