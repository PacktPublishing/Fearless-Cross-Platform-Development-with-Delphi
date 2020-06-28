unit uHHGuideFuncs;

interface

function UniversalLifeAnswer: Integer; cdecl;
exports UniversalLifeAnswer;

implementation

function UniversalLifeAnswer: Integer; cdecl;
begin
  Result := 42;
end;

end.
