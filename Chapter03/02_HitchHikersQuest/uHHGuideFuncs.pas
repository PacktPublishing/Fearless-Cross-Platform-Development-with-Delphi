unit uHHGuideFuncs;

interface

function UniversalLifeAnswer: Integer; stdcall;
exports UniversalLifeAnswer;

implementation

function UniversalLifeAnswer: Integer; stdcall;
begin
  Result := 42;
end;

end.
