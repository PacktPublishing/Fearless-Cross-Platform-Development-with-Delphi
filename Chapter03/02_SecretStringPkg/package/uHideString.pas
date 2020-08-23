unit uHideString;

interface

function HideString(const MyString: ShortString): ShortString;


implementation

function HideString(const MyString: ShortString): ShortString;
begin
  // manipulate the string to hide its original contents
  for var i := 1 to Length(MyString) do
    Result := Result + Chr(Random(26) + Ord('A')) + MyString[i];
end;

end.
