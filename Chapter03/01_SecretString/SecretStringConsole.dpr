program SecretStringConsole;
{$APPTYPE CONSOLE}

uses SysUtils, Winapi.Windows;

type
  // declare function types that we'll access
  THideStringFunc = function(const MyString: ShortString): ShortString; stdcall;
var
  astr: ShortString;
  ostr: ShortString;
  done: Boolean;

  // handle to DLL
  DllHandle: HModule;
  // pointer to the function in DLL
  HideString: THideStringFunc;
begin
  // initialize the DLL handle
  DllHandle := LoadLibrary('HideStringLib.dll');

  if DLLHandle = 0 then begin
    Write('Could not find function library...');
    Readln;
  end else begin
    // DLL loaded, assign the function
    @HideString := GetProcAddress(DllHandle, 'HideString');

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

    // free the function library
    FreeLibrary(DllHandle);
  end;
end.
