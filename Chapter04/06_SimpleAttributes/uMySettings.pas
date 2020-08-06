unit uMySettings;

interface

uses
  System.SysUtils, System.DateUtils, System.StrUtils,
  uIniSave;

type
  [IniSaveClass]
  TMySettings = class
  private
    FMyName: string;
    FMyFavNumber: Integer;
    FMyBirthDateStr: string;
    function GetMyBirthDate: TDateTime;
    procedure SetMyBirthDate(const Value: TDateTime);
  published
    [IniDefault('42')]
    property MyFavNumber: Integer read FMyFavNumber write FMyFavNumber;
    [IniDefault('Zeek')]
    property MyName: string read FMyName write FMyName;
    [IniIgnore]
    property MyBirthDate: TDateTime read GetMyBirthDate write SetMyBirthDate;
    property MyBirthDateStr: string read FMyBirthDateStr write FMyBirthDateStr;
  end;


implementation

{ TMySettings }

function TMySettings.GetMyBirthDate: TDateTime;
begin
  if Length(FMyBirthDateStr) = 10 then
    Result := EncodeDateTime(StrToInt(LeftStr(FMyBirthDateStr, 4)),
                             StrToInt(MidStr(FMyBirthDateStr, 6, 2)),
                             StrToInt(RightStr(FMyBirthDateStr, 2)),
                             0, 0, 0, 0)
  else
    Result := EncodeDateTime(1980, 1, 1, 0, 0, 0, 0);
end;

procedure TMySettings.SetMyBirthDate(const Value: TDateTime);
begin
  FMyBirthDateStr := FormatDateTime('yyyy-mm-dd', Value);
end;

end.
