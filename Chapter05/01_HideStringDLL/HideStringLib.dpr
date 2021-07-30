library HideStringLib;
uses
  ShareMem;

function HideString(const MyString: string): string; stdcall;
begin
  // manipulate the string to hide its original contents
  for var i := 1 to Length(MyString) do
    Result := Result + Chr(Random(26) + Ord('A')) + MyString[i];
end;

exports HideString;

begin
end.
