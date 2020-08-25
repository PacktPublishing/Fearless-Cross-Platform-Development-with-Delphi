unit uHideStringFunc;

interface

function HideString(const MyString: string; const UseNumbers: Boolean = False;
                                            const ReverseStr: Boolean = False): string;


implementation

function RandomChar(const ReturnDigit: Boolean = False): Char;
begin
  if ReturnDigit then
    Result := Chr(Random(10) + Ord('0'))
  else
    Result := Chr(Random(26) + Ord('A'));
end;

function HideString(const MyString: string; const UseNumbers: Boolean = False;
                                            const ReverseStr: Boolean = False): string;
begin
  // manipulate the string to hide its original contents
  if ReverseStr then
    for var i := Length(MyString) downto 1 do
      Result := Result + RandomChar(UseNumbers) + MyString[i]
  else
    for var i := 1 to Length(MyString) do
      Result := Result + RandomChar(UseNumbers) + MyString[i];
end;

end.
