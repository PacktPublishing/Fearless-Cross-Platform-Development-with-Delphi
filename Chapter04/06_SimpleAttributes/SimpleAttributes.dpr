program SimpleAttributes;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  uIniSave in 'uIniSave.pas',
  uMySettings in 'uMySettings.pas';

const
  NAME_LIST: array[1..10] of string = ('Adam', 'Bob', 'Cindy', 'Doug', 'Edgar',
                                       'Fred', 'Mary', 'Nannette', 'Olivia', 'Pauli');
var
  LMySettings: TMySettings;
  LMyIniFilename: string;
begin
  Writeln('Attribute Example');

  LMyIniFilename := ChangeFileExt(ParamStr(0), '.ini');

  LMySettings := TMySettings.Create;
  try
    // load the settings--use defaults if the .INI file does not exist
    TIniSave.Load(LMyIniFilename, LMySettings);

    Writeln('My name is: ' + LMySettings.MyName);
    Writeln('My birthdate is: ' + FormatDateTime('mmm dd, yyyy', LMySettings.MyBirthDate));
    Writeln('My favorite number is: ' + IntToStr(LMySettings.MyFavNumber));

    // change the settings so they're different next time we run this
    LMySettings.MyName := NAME_LIST[Random(10) + 1];
    LMySettings.MyBirthDate := Date - Random(20000) - 100;
    LMySettings.MyFavNumber := Random(100);

    // save our new settings
    TIniSave.Save(LMyIniFilename, LMySettings);
  finally
    LMySettings.Free;
  end;

  Readln;
end.
