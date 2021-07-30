unit uHideStringFunc;

interface

function HideString(const MyString: string): string;


implementation

function HideString(const MyString: string): string;
begin
  // manipulate the string to hide its original contents
  for var i := 1 to Length(MyString) do
    Result := Result + Chr(Random(26) + Ord('A')) + MyString[i];
end;

end.
